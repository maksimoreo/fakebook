document.addEventListener("turbolinks:load", function() {
    // Close notifications
    (document.querySelectorAll(".notification .delete") || []).forEach(($delete) => {
        var $notification = $delete.parentNode;
        $delete.addEventListener('click', () => {
            $notification.parentNode.removeChild($notification);
        });
    });

    // Toggle navbar on mobile
    burgerIcon = document.querySelector("#burger");
    navbarMenu = document.querySelector("#nav-links");
    burgerIcon.addEventListener("click", () => {
        navbarMenu.classList.toggle("is-active");
    });
});
