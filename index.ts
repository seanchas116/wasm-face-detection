const canvas = document.getElementById('canvas')

;(window as any).Module = {
    canvas: canvas,
    onRuntimeInitialized: () => {
        console.log('lerp result: ' + (Module as any).lerp(1, 2, 0.5));
    }
}

;(async () => {
    const video = document.getElementById('video') as HTMLVideoElement
    const stream = await navigator.mediaDevices.getUserMedia({
        audio: false,
        video: {
          width: { ideal: video.width },
          height: { ideal: video.height },
        },
    })
    video.srcObject = stream

    const videoCanvas = document.getElementById('videocanvas') as HTMLCanvasElement
    const context = videoCanvas.getContext('2d')!

    const updateCanvas = () => {
        context.drawImage(video, 0, 0)
        requestAnimationFrame(updateCanvas)
    }
    updateCanvas()
})()
