// app/javascript/toggle_button.js

// チェックボックスの状態に応じてボタンの有効・無効を切り替える関数
function toggleButton() {
  const checkbox = document.getElementById('terms1');
  const button = document.getElementById('agree-button');
  if (checkbox && button) {
    button.disabled = !checkbox.checked; // チェックされていない場合はボタンを無効化
  }
}

// ページの読み込みが完了したら、イベントリスナーを追加
document.addEventListener('DOMContentLoaded', () => {
  const checkbox = document.getElementById('terms1');
  if (checkbox) {
    checkbox.addEventListener('change', toggleButton);
  }
});
