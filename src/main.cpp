#include <SDL/SDL.h>
#include <emscripten.h>
#include <emscripten/bind.h>
#include <dlib/array2d.h>
#include <dlib/image_processing/frontal_face_detector.h>
#include <dlib/image_processing.h>
#include <dlib/image_transforms/draw.h>
#include <dlib/opencv.h>
#include <opencv2/opencv.hpp>
#include <opencv2/tracking.hpp>
#include <tensorflow/lite/interpreter.h>
#include <tensorflow/lite/kernels/register.h>
#include <tensorflow/lite/model.h>

class FaceDetector {
 public:
  FaceDetector() {
    dlib::deserialize("/shape_predictor_68_face_landmarks.dat") >> poseModel;
  }

  std::vector<cv::Rect2d> detectTrackFaces(const cv::Mat& bgrImage) {
    if (tracker && trackableCount > 0) {
      cv::Rect2d outRect;
      if (tracker->update(bgrImage, outRect)) {
        --trackableCount;
        return {outRect};
      }
    }
    tracker.reset();
    std::vector<dlib::rectangle> faces = faceDetector(dlib::cv_image<dlib::bgr_pixel>(bgrImage));
    if (faces.empty()) {
      return {};
    }
    auto face = faces.at(0);
    cv::Rect2d rect(face.left(), face.top(), face.width(), face.height());
    tracker = cv::TrackerKCF::create();
    tracker->init(bgrImage, rect);
    trackableCount = 20;
    return {rect};
  }

  std::vector<cv::Point2d> detectLandmarks(const cv::Mat& bgrImage, const cv::Rect2d& face) {
    dlib::rectangle dlibFace(face.tl().x, face.tl().y, face.br().x, face.br().y);
    dlib::full_object_detection shape = poseModel(dlib::cv_image<dlib::bgr_pixel>(bgrImage), dlibFace);
    std::vector<cv::Point2d> points(shape.num_parts());
    for (int i = 0; i < shape.num_parts(); ++i) {
      points[i] = cv::Point2d(shape.part(i).x(), shape.part(i).y());
    }
    return points;
  }

 private:
  dlib::frontal_face_detector faceDetector = dlib::get_frontal_face_detector();
  dlib::shape_predictor poseModel;
  std::shared_ptr<cv::Tracker> tracker;
  int trackableCount = 0;
};

class PersonSegmenter {
 public:
  PersonSegmenter() {
    _model = tflite::FlatBufferModel::BuildFromFile("/deeplabv3_257_mv_gpu.tflite");
    tflite::ops::builtin::BuiltinOpResolver resolver;
    tflite::InterpreterBuilder(*_model, resolver)(&_interpreter);
  }

 private:
  std::unique_ptr<tflite::FlatBufferModel> _model;
  std::unique_ptr<tflite::Interpreter> _interpreter;
};

namespace {

constexpr int WIDTH = 320;
constexpr int HEIGHT = 240;
SDL_Surface* screen = nullptr;
FaceDetector faceDetector;

}

extern "C" int main(int argc, char** argv) {

  SDL_Init(SDL_INIT_VIDEO);
  screen = SDL_SetVideoMode(WIDTH, HEIGHT, 32, SDL_SWSURFACE);

  return 0;
}

void detectAndRender(size_t addr, int width, int height) {
  auto data = reinterpret_cast<void *>(addr);
  cv::Mat rgbaImage(height, width, CV_8UC4, data); // RGBA
  cv::Mat bgrImage;
  cv::cvtColor(rgbaImage, bgrImage, cv::COLOR_RGBA2BGR);

  auto faces = faceDetector.detectTrackFaces(bgrImage);

  for (auto&& face : faces) {
    cv::rectangle(bgrImage, face, cv::Scalar(255, 0, 0));
    auto landmarks = faceDetector.detectLandmarks(bgrImage, face);
    for (auto&& p : landmarks) {
      cv::circle(bgrImage, p, 2, cv::Scalar(0, 255, 0));
    }
  }

  if (SDL_MUSTLOCK(screen)) SDL_LockSurface(screen);
  cv::Mat dstRGBAImage(height, width, CV_8UC4, screen->pixels);
  cv::cvtColor(bgrImage, dstRGBAImage, cv::COLOR_BGR2RGBA);
  if (SDL_MUSTLOCK(screen)) SDL_UnlockSurface(screen);
  SDL_Flip(screen); 
}

EMSCRIPTEN_BINDINGS(my_module) {
    emscripten::function("detectAndRender", &detectAndRender);
}