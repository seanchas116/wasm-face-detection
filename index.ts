interface EmscriptenModule {
  putImageData(data: number, size: number): void
}

window.Module = {
  canvas: document.getElementById('canvas'),
  onRuntimeInitialized: init,
} as any

async function init() {
  const video = document.createElement('video')
  video.width = 320
  video.height = 240
  video.autoplay = true
  const stream = await navigator.mediaDevices.getUserMedia({
    audio: false,
    video: {
      width: { ideal: video.width },
      height: { ideal: video.height },
    },
  })
  video.srcObject = stream

  const videoCanvas = document.createElement('canvas')
  videoCanvas.width = video.width
  videoCanvas.height = video.height
  const context = videoCanvas.getContext('2d')!

  const updateCanvas = () => {
    context.drawImage(video, 0, 0)
    const data = context.getImageData(0, 0, videoCanvas.width, videoCanvas.height)

    const buffer = Module._malloc(data.data.length)
    Module.HEAPU8.set(data.data, buffer);
    Module.putImageData(buffer, data.data.length)
    Module._free(buffer)

    requestAnimationFrame(updateCanvas)
  }
  updateCanvas()
}
