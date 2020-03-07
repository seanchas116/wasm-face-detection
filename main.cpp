#include <SDL/SDL.h>
#include <emscripten.h>
#include <emscripten/bind.h>
#include <dlib/array2d.h>
#include <dlib/image_processing/frontal_face_detector.h>
#include <dlib/image_processing.h>
#include <dlib/image_transforms/draw.h>
#include <dlib/opencv.h>
#include <opencv2/opencv.hpp>

namespace {

constexpr int WIDTH = 320;
constexpr int HEIGHT = 240;
SDL_Surface* screen = nullptr;
dlib::frontal_face_detector faceDetector = dlib::get_frontal_face_detector();
dlib::shape_predictor poseModel;

}

extern "C" int main(int argc, char** argv) {
  cv::Mat hoge(100, 100, CV_8UC3);

  dlib::deserialize("/shape_predictor_68_face_landmarks.dat") >> poseModel;

  SDL_Init(SDL_INIT_VIDEO);
  screen = SDL_SetVideoMode(WIDTH, HEIGHT, 32, SDL_SWSURFACE);

  return 0;
}

void detectAndRender(size_t addr, int width, int height) {
  auto data = reinterpret_cast<void *>(addr);
  cv::Mat rgbaImage(height, width, CV_8UC4, data); // RGBA
  cv::Mat bgrImage;
  cv::cvtColor(rgbaImage, bgrImage, cv::COLOR_RGBA2BGR);

  dlib::cv_image<dlib::bgr_pixel> dlibImage(bgrImage);

  std::vector<dlib::rectangle> faces = faceDetector(dlibImage);
  for (auto&& face : faces) {
    dlib::draw_rectangle(dlibImage, face, dlib::bgr_pixel(255, 0, 0));
    dlib::full_object_detection shape = poseModel(dlibImage, face);
    for (int i = 0; i < shape.num_parts(); ++i) {
      auto p = shape.part(i);
      dlib::draw_solid_circle(dlibImage, p, 2, dlib::bgr_pixel(0, 255, 0));
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