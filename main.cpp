#include <stdio.h>
#include <SDL/SDL.h>
#include <emscripten.h>
#include <emscripten/bind.h>

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

void putImageData(const emscripten::val& data$) {
  if (SDL_MUSTLOCK(screen)) SDL_LockSurface(screen);
  auto vec = emscripten::vecFromJSArray<uint8_t>(data$);
  memcpy(screen->pixels, vec.data(), vec.size());
  if (SDL_MUSTLOCK(screen)) SDL_UnlockSurface(screen);
  SDL_Flip(screen); 
}

EMSCRIPTEN_BINDINGS(my_module) {
    emscripten::function("putImageData", &putImageData);
}