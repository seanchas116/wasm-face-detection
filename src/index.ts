interface EmscriptenModule {
  detectAndRender(data: number, width: number, height: number): void;
}

const preRun = () => {
  FS.createPreloadedFile(
    "/",
    "shape_predictor_68_face_landmarks.dat",
    "shape_predictor_68_face_landmarks.dat",
    true,
    false
  );
  FS.createPreloadedFile(
    "/",
    "deeplabv3_257_mv_gpu.tflite",
    "deeplabv3_257_mv_gpu.tflite",
    true,
    false
  );
};

const init = async () => {
  const video = document.createElement("video");
  video.width = 200;
  video.height = 150;
  const stream = await navigator.mediaDevices.getUserMedia({
    audio: false,
    video: {
      width: { ideal: video.width },
      height: { ideal: video.height },
    },
  });
  video.srcObject = stream;
  video.play();

  const videoCanvas = document.createElement("canvas");
  videoCanvas.width = video.width;
  videoCanvas.height = video.height;
  const context = videoCanvas.getContext("2d")!;

  const updateCanvas = () => {
    context.drawImage(video, 0, 0);
    const data = context.getImageData(
      0,
      0,
      videoCanvas.width,
      videoCanvas.height
    );

    const buffer = Module._malloc(data.data.length);
    Module.HEAPU8.set(data.data, buffer);
    Module.detectAndRender(buffer, data.width, data.height);
    Module._free(buffer);

    requestAnimationFrame(updateCanvas);
  };
  updateCanvas();

  document.getElementById("loading")!.hidden = true;
};

window.Module = {
  canvas: document.getElementById("canvas"),
  preRun: preRun,
  onRuntimeInitialized: init,
} as any;
