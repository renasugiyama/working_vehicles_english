document.addEventListener('turbo:load', function() {
  const termsCheckbox = document.getElementById('terms-checkbox');
  const privacyCheckbox = document.getElementById('privacy-checkbox');
  const registerButton = document.getElementById('register-button');

  const nameInput = document.querySelector('[name="user[name]"]');
  const emailInput = document.querySelector('[name="user[email]"]');
  const passwordInput = document.querySelector('[name="user[password]"]');
  const passwordConfirmationInput = document.querySelector('[name="user[password_confirmation]"]');

  // ボタンの状態を切り替える関数
  function toggleRegisterButton() {
    const isTermsChecked = termsCheckbox ? termsCheckbox.checked : false;
    const isPrivacyChecked = privacyCheckbox ? privacyCheckbox.checked : false;
    const isNameFilled = nameInput ? nameInput.value.trim() !== '' : false;
    const isEmailFilled = emailInput ? emailInput.value.trim() !== '' : false;
    const isPasswordFilled = passwordInput ? passwordInput.value.trim() !== '' : false;
    const isPasswordConfirmationFilled = passwordConfirmationInput ? passwordConfirmationInput.value.trim() !== '' : false;

    // すべての条件が満たされている場合、ボタンを有効化
    if (
      isTermsChecked &&
      isPrivacyChecked &&
      isNameFilled &&
      isEmailFilled &&
      isPasswordFilled &&
      isPasswordConfirmationFilled
    ) {
      registerButton.disabled = false;
      registerButton.classList.remove('bg-gray-400', 'cursor-not-allowed');
      registerButton.classList.add('bg-blue-600', 'hover:bg-blue-700');
    } else {
      registerButton.disabled = true;
      registerButton.classList.remove('bg-blue-600', 'hover:bg-blue-700');
      registerButton.classList.add('bg-gray-400', 'cursor-not-allowed');
    }
  }

  // チェックボックスと入力フィールドの変更を監視
  if (termsCheckbox) termsCheckbox.addEventListener('change', toggleRegisterButton);
  if (privacyCheckbox) privacyCheckbox.addEventListener('change', toggleRegisterButton);
  if (nameInput) nameInput.addEventListener('input', toggleRegisterButton);
  if (emailInput) emailInput.addEventListener('input', toggleRegisterButton);
  if (passwordInput) passwordInput.addEventListener('input', toggleRegisterButton);
  if (passwordConfirmationInput) passwordConfirmationInput.addEventListener('input', toggleRegisterButton);

  // 初回ロード時にボタンの状態を確認
  toggleRegisterButton();
});
