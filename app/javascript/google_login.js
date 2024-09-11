// app/javascript/google_login.js
document.addEventListener("turbo:load", function () {
  const checkbox = document.getElementById("terms-checkbox");
  const googleLoginLink = document.getElementById("google-login-link");

  // 初期状態でリンクを無効にする
  if (googleLoginLink) {
    googleLoginLink.classList.add("text-gray-400", "cursor-not-allowed", "pointer-events-none");
  }

  if (checkbox) {
    checkbox.addEventListener("change", function () {
      if (checkbox.checked) {
        googleLoginLink.classList.remove("text-gray-400", "cursor-not-allowed", "pointer-events-none");
      } else {
        googleLoginLink.classList.add("text-gray-400", "cursor-not-allowed", "pointer-events-none");
      }
    });
  }
});
