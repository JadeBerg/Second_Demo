function deltaLine(progress) {
    return progress;
}

function moveLogo(){
    let element = document.getElementById("logo");
    let from = -100; // Начальная координата Y
    let to = 0; // Конечная координата Y
    let duration = 2000; // Длительность - 1 секунда
    let start = new Date().getTime(); // Время старта

    setTimeout(function() {
        let now = (new Date().getTime()) - start; // Текущее время
        let progress = now / duration; // Прогресс анимации

        let result = (to - from) * deltaLine(progress) + from;

        element.style.top = result + "px";

        if (progress < 1) // Если анимация не закончилась, продолжаем
            setTimeout(arguments.callee, 40);
    }, 40);
}
