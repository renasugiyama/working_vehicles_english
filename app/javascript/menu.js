document.addEventListener("turbo:load", function() {
  var menuButton = document.getElementById("menuButton");
  var menuDropdown = document.getElementById("menuDropdown");

  if (menuButton && menuDropdown) {
    menuButton.addEventListener("click", function() {
      menuDropdown.classList.toggle("hidden");
    });
  }
});

document.addEventListener("turbo:before-cache", function() {
  var menuDropdown = document.getElementById("menuDropdown");
  if (menuDropdown) {
    menuDropdown.classList.add("hidden");
  }
});
