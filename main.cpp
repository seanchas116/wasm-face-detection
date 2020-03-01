#include <stdio.h>
#include <SDL/SDL.h>
#include <emscripten.h>
#include <emscripten/bind.h>
#include <dlib/array2d.h>
#include <dlib/image_processing/frontal_face_detector.h>
#include <dlib/image_transforms/draw.h>

namespace {

constexpr int WIDTH = 320;
constexpr int HEIGHT = 240;
SDL_Surface* screen = nullptr;
dlib::frontal_face_detector faceDetector = dlib::get_frontal_face_detector();

}

extern "C" int main(int argc, char** argv) {
  printf("hello, world!\n");

  SDL_Init(SDL_INIT_VIDEO);
  screen = SDL_SetVideoMode(WIDTH, HEIGHT, 32, SDL_SWSURFACE);

  return 0;
}

void putDlibImage(const dlib::array2d<dlib::bgr_pixel>& image) {
  auto dst = reinterpret_cast<uint8_t *>(screen->pixels);
  for (int y = 0; y < image.nr(); ++y) {
    for (int x = 0; x < image.nc(); ++x) {
      *dst++ = image[y][x].red;
      *dst++ = image[y][x].green;
      *dst++ = image[y][x].blue;
      *dst++ = 255;
    }
  }
}

void detectAndRender(size_t addr, int width, int height) {
  auto data = reinterpret_cast<const uint8_t *>(addr);

  dlib::array2d<dlib::bgr_pixel> image(height, width);
  {
    auto p = data;
    for (int y = 0; y < height; ++y) {
      for (int x = 0; x < width; ++x) {
        image[y][x].red = *p++;
        image[y][x].green = *p++;
        image[y][x].blue = *p++;
        p++;
      }
    }
  }

  std::vector<dlib::rectangle> faces = faceDetector(image);
  for (auto&& face : faces) {
    dlib::draw_rectangle(image, face, dlib::bgr_pixel(255, 0, 0));
  }

  if (SDL_MUSTLOCK(screen)) SDL_LockSurface(screen);
  putDlibImage(image);
  if (SDL_MUSTLOCK(screen)) SDL_UnlockSurface(screen);
  SDL_Flip(screen); 
}

EMSCRIPTEN_BINDINGS(my_module) {
    emscripten::function("detectAndRender", &detectAndRender);
}