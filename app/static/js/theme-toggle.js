document.addEventListener('DOMContentLoaded', function () {
    const themeStyle = document.getElementById('theme-style');
    const dynamicLogo = document.getElementById('dynamic-logo');
    const footerLogo = document.getElementById('footer-logo');
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
    }
});
