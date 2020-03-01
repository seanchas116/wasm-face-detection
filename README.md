# wasm-face-detection
Face Detection using dlib/OpenCV in WebAssembly

[Try](https://seanchas116.github.io/wasm-face-detection/)

## Prerequisites

* cmake
* Install emscripten with [emsdk](https://github.com/emscripten-core/emsdk)
  * Activate emscripten installation with `source /path/to/emsdk/emsdk_env.sh`

## Run

```
npm install
npm run configure:cpp
npm run build:cpp
npm run serve
```
