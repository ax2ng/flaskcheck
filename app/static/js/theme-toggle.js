document.addEventListener('DOMContentLoaded', function () {
    const themeStyle = document.getElementById('theme-style');
    const dynamicLogo = document.getElementById('dynamic-logo');
    const footerLogo = document.getElementById('footer-logo');
    const headerLogo = document.getElementById('header-logo');
    const arrow = document.getElementById('arrow');
    const switchh = document.getElementById('switchh');
    let currentTheme = localStorage.getItem('theme') || getDefaultTheme();



    // Применяем начальную тему
    applyTheme(currentTheme);

    // Добавляем обработчик на каждую кнопку смены темы
    document.querySelectorAll('.toggle-theme-button').forEach(button => {
        button.addEventListener('click', (event) => {
            event.preventDefault();
            currentTheme = currentTheme === 'light' ? 'dark' : 'light'; // Переключаем значение
            applyTheme(currentTheme);
            localStorage.setItem('theme', currentTheme); // Сохраняем новый выбор в localStorage
        });
    });

    function getDefaultTheme() {
        const hour = new Date().getHours();
        return hour >= 7 && hour < 19 ? 'light' : 'dark';
    }

    function applyTheme(theme) {
        themeStyle.href = theme === 'dark' ? "/static/css/styles.css" : "/static/css/light-theme.css";

        // Меняем логотип в зависимости от темы
        if (dynamicLogo) {
            dynamicLogo.src = theme === 'dark' ? "/static/img/logo.svg" : "/static/img/logowhite.svg";
        }
        if (footerLogo) {
            footerLogo.src = theme === 'dark' ? "/static/img/logo.svg" : "/static/img/logowhite.svg";
        }
        if (headerLogo) {
            headerLogo.src = theme === 'dark' ? "/static/img/logo.svg" : "/static/img/logofooter.svg";
        }
        if (arrow) {
            arrow.src = theme === 'dark' ? "/static/img/arrow.svg" : "/static/img/arrowwhite.svg";
        }
        if (switchh) {
            switchh.src = theme === 'dark' ? "/static/img/switch.svg" : "/static/img/switchwhite.svg";
        }
    }
});


document.addEventListener('DOMContentLoaded', function () {
    const toggleThemeButton = document.getElementById('toggle-theme-button');

    toggleThemeButton.addEventListener('click', function () {
        toggleThemeButton.classList.add('rotate');

        // Удаление класса после завершения анимации
        toggleThemeButton.addEventListener('animationend', function () {
            toggleThemeButton.classList.remove('rotate');
        }, { once: true }); // { once: true } гарантирует, что обработчик удалится после первого выполнения
    });
});