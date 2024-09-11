// app/javascript/toggle_button.js

// チェックボックスの状態に応じてボタンの有効・無効を切り替える関数
function toggleButton() {
  const checkbox = document.getElementById('terms1');
  const button = document.getElementById('agree-button');
  if (checkbox && button) {
    if (checkbox.checked) {
      button.disabled = false;
      button.classList.remove('bg-gray-400', 'cursor-not-allowed');
      button.classList.add('bg-blue-500', 'cursor-pointer');
    } else {
      button.disabled = true;
      button.classList.remove('bg-blue-500', 'cursor-pointer');
      button.classList.add('bg-gray-400', 'cursor-not-allowed');
    }
  }
}

// Turboがページを更新する時にJavaScriptが再実行されるように設定
document.addEventListener('turbo:load', () => {
  const checkbox = document.getElementById('terms1');
  if (checkbox) {
    checkbox.addEventListener('change', toggleButton);
  }
  toggleButton(); // 初期状態を設定
});