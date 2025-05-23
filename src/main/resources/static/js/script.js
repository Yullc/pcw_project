let scrollIndex = 0;
const totalSections = 3;

window.addEventListener("wheel", (e) => {
    e.preventDefault();

    if (e.deltaY > 0 && scrollIndex < totalSections - 1) {
        scrollIndex++;
    } else if (e.deltaY < 0 && scrollIndex > 0) {
        scrollIndex--;
    }

    document.getElementById("horizontal-scroll").style.transform = `translateX(-${scrollIndex * 100}vw)`;
}, { passive: false });
