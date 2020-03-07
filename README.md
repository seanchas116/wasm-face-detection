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

## How to build OpenCV 4.2.0 for Emscripten (with contrib)

* clone opencv and opencv_contrib
* Edit opencv/platforms/js/build_js.py

```
diff --git a/platforms/js/build_js.py b/platforms/js/build_js.py
index 10e04ea020..52747c31d2 100644
--- a/platforms/js/build_js.py
+++ b/platforms/js/build_js.py
@@ -78,6 +78,8 @@ class Builder:
 
     def get_cmake_cmd(self):
         cmd = ["cmake",
+               "-DCMAKE_INSTALL_PREFIX=/path/to/install",
+               "-DOPENCV_EXTRA_MODULES_PATH=/path/to/opencv_contrib/modules",
                "-DENABLE_PIC=FALSE", # To workaround emscripten upstream backend issue https://github.com/emscripten-core/emscripten/issues/8761
                "-DCMAKE_BUILD_TYPE=Release",
                "-DCMAKE_TOOLCHAIN_FILE='%s'" % self.get_toolchain_file(),
@@ -123,7 +125,7 @@ class Builder:
                "-DBUILD_opencv_gapi=OFF",
                "-DBUILD_opencv_ml=OFF",
                "-DBUILD_opencv_photo=ON",
-               "-DBUILD_opencv_imgcodecs=OFF",
+               "-DBUILD_opencv_imgcodecs=ON",
                "-DBUILD_opencv_shape=OFF",
                "-DBUILD_opencv_videoio=OFF",
                "-DBUILD_opencv_videostab=OFF",
@@ -132,10 +134,11 @@ class Builder:
                "-DBUILD_opencv_stitching=OFF",
                "-DBUILD_opencv_java=OFF",
                "-DBUILD_opencv_java_bindings_generator=OFF",
-               "-DBUILD_opencv_js=ON",
+               "-DBUILD_opencv_js=OFF",
                "-DBUILD_opencv_python2=OFF",
                "-DBUILD_opencv_python3=OFF",
                "-DBUILD_opencv_python_bindings_generator=OFF",
+               "-DBUILD_opencv_dnn_objdetect=OFF",
                "-DBUILD_EXAMPLES=OFF",
                "-DBUILD_PACKAGE=OFF",
                "-DBUILD_TESTS=OFF",
```

* `cd opencv`
* `python ./platforms/js/build_js.py build_wasm --build_wasm --emscripten_dir=/path/to/emscripten --config_only`
* `cd build_wasm`
* `emmake make`
* `emmake make install`
