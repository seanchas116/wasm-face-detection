const canvas = document.getElementById('canvas')

;(window as any).Module = {
    canvas: canvas,
    onRuntimeInitialized: init,
}

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

    const videoCanvas = document.getElementById('videocanvas') as HTMLCanvasElement
    const context = videoCanvas.getContext('2d')!

    const updateCanvas = () => {
        context.drawImage(video, 0, 0)
        const data = context.getImageData(0, 0, videoCanvas.width, videoCanvas.height)
        console.log(data)
        ;(window as any).Module.putImageData(data.data)
        requestAnimationFrame(updateCanvas)
    }
    updateCanvas()
}
