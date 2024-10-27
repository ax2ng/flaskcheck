document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.btn').forEach(button => {
        button.addEventListener('click', function (e) {
            let rect = button.getBoundingClientRect();
            let ripple = document.createElement('span');
            ripple.className = 'ripple';
            ripple.style.left = `${e.clientX - rect.left}px`;
            ripple.style.top = `${e.clientY - rect.top}px`;
            button.appendChild(ripple);
            setTimeout(() => ripple.remove(), 600);
        });
    });

    document.querySelectorAll('.form-control').forEach(input => {
        input.addEventListener('focus', function () {
            input.parentNode.classList.add('input-focus');
        });
        input.addEventListener('blur', function () {
            input.parentNode.classList.remove('input-focus');
        });
    });
});

    document.addEventListener('DOMContentLoaded', function() {
        const alertContainer = document.getElementById('alert-container');
        if (alertContainer) {
            alertContainer.classList.add('show'); // Добавляем класс для анимации появления

            // Ждем 2 секунды
            setTimeout(() => {
                // Плавное исчезновение
                alertContainer.style.opacity = '0'; // Уменьшаем прозрачность до 0
                alertContainer.style.transition = 'opacity 0.5s ease'; // Плавный переход
                // Ждем еще 0.5 секунды и удаляем контейнер
                setTimeout(() => {
                    alertContainer.remove();
                }, 500); // Удаляем элемент после исчезновения
            }, 1500); // Время, через которое начинается исчезновение (2 секунды)
        }
    });


document.addEventListener("DOMContentLoaded", function() {
    const elements = document.querySelectorAll(".intro-logo, .intro-text, .intro-bear, .intro-login-button");

    elements.forEach((el, index) => {
        el.style.opacity = 0;
        setTimeout(() => {
            el.style.opacity = 1;
            el.style.transform = "scale(1)";
        }, index * 500); // Появление с задержкой в 500 мс
    });
});

