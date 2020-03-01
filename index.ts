const canvas = document.getElementById('canvas')

;(window as any).Module = {
    canvas: canvas,
    onRuntimeInitialized: () => {
        console.log('lerp result: ' + (Module as any).lerp(1, 2, 0.5));
    }
}
