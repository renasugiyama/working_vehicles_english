document.addEventListener("DOMContentLoaded", function() {
  var menuButton = document.getElementById("menuButton");
  var menuDropdown = document.getElementById("menuDropdown");

  menuButton.addEventListener("click", function() {
    menuDropdown.classList.toggle("hidden");
  });
});
