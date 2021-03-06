#include <SDL/SDL.h>
#include <dlib/array2d.h>
#include <dlib/image_processing.h>
#include <dlib/image_processing/frontal_face_detector.h>
#include <dlib/image_transforms/draw.h>
#include <dlib/opencv.h>
#include <emscripten.h>
#include <emscripten/bind.h>
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

  std::vector<cv::Rect2d> detectTrackFaces(const cv::Mat &bgrImage) {
    if (tracker && trackableCount > 0) {
      cv::Rect2d outRect;
      if (tracker->update(bgrImage, outRect)) {
        --trackableCount;
        return {outRect};
      }
    }
    tracker.reset();
    std::vector<dlib::rectangle> faces =
        faceDetector(dlib::cv_image<dlib::bgr_pixel>(bgrImage));
    if (faces.empty()) {
      return {};
    }
    auto face = faces.at(0);
    cv::Rect2d rect(face.left(), face.top(), face.width(), face.height());
    tracker = cv::TrackerMedianFlow::create();
    tracker->init(bgrImage, rect);
    trackableCount = 20;
    return {rect};
  }

  std::vector<cv::Point2d> detectLandmarks(const cv::Mat &bgrImage,
                                           const cv::Rect2d &face) {
    dlib::rectangle dlibFace(face.tl().x, face.tl().y, face.br().x,
                             face.br().y);
    dlib::full_object_detection shape =
        poseModel(dlib::cv_image<dlib::bgr_pixel>(bgrImage), dlibFace);
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
    _model =
        tflite::FlatBufferModel::BuildFromFile("/deeplabv3_257_mv_gpu.tflite");
    tflite::ops::builtin::BuiltinOpResolver resolver;
    tflite::InterpreterBuilder(*_model, resolver)(&_interpreter);
    _interpreter->SetNumThreads(1);
    if (_interpreter->AllocateTensors() != kTfLiteOk) {
      std::cerr << "Error AllocateTensors" << std::endl;
    }
  }

  cv::Mat segment(const cv::Mat &bgrImage) {
    cv::Mat input;
    cv::resize(bgrImage, input, cv::Size(_inputSize, _inputSize));
    cv::cvtColor(input, input, cv::COLOR_BGR2RGB);
    input.convertTo(input, CV_32FC3, 1 / 255.0);

    auto inputData =
        _interpreter->typed_tensor<float>(_interpreter->inputs().at(0));
    memcpy(inputData, input.data, sizeof(float) * 3 * _inputSize * _inputSize);

    if (_interpreter->Invoke() != kTfLiteOk) {
      std::cerr << "Error Invoke" << std::endl;
    }

    auto outputData =
        _interpreter->typed_tensor<float>(_interpreter->outputs()[0]);
    cv::Mat output(_inputSize, _inputSize, CV_8UC1);

    for (int i = 0; i < _inputSize * _inputSize; ++i) {
      constexpr int classCount = 21;
      auto classes = outputData + i * classCount;
      int index = std::max_element(classes, classes + classCount) - classes;
      output.data[i] = index == 15 ? 255 : 0;
    }
    cv::cvtColor(output, output, cv::COLOR_GRAY2BGR);
    cv::resize(output, output, cv::Size(bgrImage.cols, bgrImage.rows));
    cv::addWeighted(bgrImage, 0.5, output, 0.5, 0, output);

    return output;
  }

private:
  std::unique_ptr<tflite::FlatBufferModel> _model;
  std::unique_ptr<tflite::Interpreter> _interpreter;
  constexpr static int _inputSize = 257;
};

namespace {

constexpr int WIDTH = 200;
constexpr int HEIGHT = 150;
SDL_Surface *screen = nullptr;
FaceDetector faceDetector;
PersonSegmenter personSegmenter;

} // namespace

extern "C" int main(int argc, char **argv) {

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
  std::vector<std::vector<cv::Point2d>> landmarkss;

  for (auto &&face : faces) {
    auto landmarks = faceDetector.detectLandmarks(bgrImage, face);
    landmarkss.push_back(std::move(landmarks));
  }

  // bgrImage = personSegmenter.segment(bgrImage);

  for (auto &&face : faces) {
    cv::rectangle(bgrImage, face, cv::Scalar(255, 0, 0));
  }
  for (auto &&landmarks : landmarkss) {
    for (auto &&p : landmarks) {
      cv::circle(bgrImage, p, 2, cv::Scalar(0, 255, 0));
    }
  }

  if (SDL_MUSTLOCK(screen))
    SDL_LockSurface(screen);
  cv::Mat dstRGBAImage(height, width, CV_8UC4, screen->pixels);
  cv::cvtColor(bgrImage, dstRGBAImage, cv::COLOR_BGR2RGBA);
  if (SDL_MUSTLOCK(screen))
    SDL_UnlockSurface(screen);
  SDL_Flip(screen);
}

EMSCRIPTEN_BINDINGS(my_module) {
  emscripten::function("detectAndRender", &detectAndRender);
}