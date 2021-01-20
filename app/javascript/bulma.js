document.addEventListener("turbolinks:load", function() {
    burgerIcon = document.querySelector("#burger");
    navbarMenu = document.querySelector("#nav-links");

    burgerIcon.addEventListener("click", () => {
        navbarMenu.classList.toggle("is-active");
    });
});
