// app/javascript/speak.js

// 問題文と選択肢を順番に読み上げる関数
function speakAllText() {
  if ('speechSynthesis' in window) {
    const questionContent = document.querySelector('.question-content')?.innerText || '';
    const choiceContents = Array.from(document.querySelectorAll('.choice-button')).map(button => button.innerText);
    const texts = [questionContent, ...choiceContents];
    const delayBetweenTexts = 700; // 次を読み上げるまでの間隔（ミリ秒）

    function speakTextSequentially(index) {
      if (index >= texts.length) return;

      const utterance = new SpeechSynthesisUtterance(texts[index]);
      utterance.lang = 'en-US';
      utterance.rate = 0.5;

      utterance.onend = function () {
        setTimeout(() => speakTextSequentially(index + 1), delayBetweenTexts);
      };

      speechSynthesis.speak(utterance);
    }

    speakTextSequentially(0);
  } else {
    alert('このブラウザは音声読み上げ機能をサポートしていません。');
  }
}

// グローバルスコープに関数を登録
window.speakAllText = speakAllText;
ja