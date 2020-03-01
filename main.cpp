#include <stdio.h>
#include <SDL/SDL.h>
#include <emscripten.h>
#include <emscripten/bind.h>
#include <dlib/array2d.h>

namespace {

constexpr int WIDTH = 320;
constexpr int HEIGHT = 240;
SDL_Surface* screen = nullptr;

}

extern "C" int main(int argc, char** argv) {
  printf("hello, world!\n");

  SDL_Init(SDL_INIT_VIDEO);
  screen = SDL_SetVideoMode(WIDTH, HEIGHT, 32, SDL_SWSURFACE);

  return 0;
}

void putImageData(size_t addr, int width, int height) {
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

  if (SDL_MUSTLOCK(screen)) SDL_LockSurface(screen);
  memcpy(screen->pixels, data, width * height * 4);
  if (SDL_MUSTLOCK(screen)) SDL_UnlockSurface(screen);
  SDL_Flip(screen); 
}

EMSCRIPTEN_BINDINGS(my_module) {
    emscripten::function("putImageData", &putImageData);
}