// app/javascript/player_video_settings.js
document.addEventListener('turbo:load', function () {
  console.log('Turbo:load event fired'); // イベント確認用ログ
  setupPlayerSelect();
  setupConditionSelect();
  setupIsGlobalCheckbox();

  // エラーメッセージが存在する場合に選択状態をリセットする
  if (document.querySelector('.error-message')) {
    resetSelections();
  }
});

// プレイヤー選択ボタンとオプションのイベントリスナーを設定する関数
function setupPlayerSelect() {
  const playerSelectButton = document.getElementById('player-select-button');
  const playerOptions = document.getElementById('player-options');
  const selectedPlayerDisplay = document.getElementById('selected-player-display');
  const selectedPlayerIdField = document.getElementById('selected-player-id');

  // 初期リセット処理
  resetSelections();

  // 要素の取得を確認するログ
  console.log('Player Select Button:', playerSelectButton);
  console.log('Player Options:', playerOptions);
  console.log('Selected Player Display:', selectedPlayerDisplay);
  console.log('Selected Player ID Field:', selectedPlayerIdField);

  if (playerSelectButton && playerOptions && selectedPlayerDisplay && selectedPlayerIdField) {
    playerSelectButton.addEventListener('click', function () {
      document.getElementById('condition-options').classList.add('hidden');
      playerOptions.classList.toggle('hidden');
    });

    playerOptions.addEventListener('click', function (event) {
      const selectedPlayer = event.target.closest('li');
      if (selectedPlayer) {
        const playerId = selectedPlayer.getAttribute('data-player-id');
        const playerName = selectedPlayer.getAttribute('data-player-name');
        const playerImage = selectedPlayer.getAttribute('data-player-image');

        // 選択されたプレイヤーのIDを隠しフィールドにセット
        selectedPlayerIdField.value = playerId;
        selectedPlayerIdField.name = "player_video_setting[player_id]";
        document.getElementById('selected-condition-value').name = "player_video_setting[play_video_after_correct_count]";

        // すべてのチェックアイコンを非表示
        document.querySelectorAll('.check-icon').forEach(icon => icon.classList.add('hidden'));

        // 選択されたプレイヤーにチェックアイコンを表示
        selectedPlayer.querySelector('.check-icon').classList.remove('hidden');

        // 選択されたプレイヤーの情報を表示部分に反映
        selectedPlayerDisplay.innerHTML = `
          <div class="player-icon w-16 h-16 bg-gray-200 rounded-full flex items-center justify-center ml-4 overflow-hidden">
            ${playerImage ? `<img src="${playerImage}" alt="プレイヤーアイコン" class="w-full h-full object-cover">` : `<span>${playerName}</span>`}
          </div>
          <span class="ml-3 block truncate">${playerName}</span>
        `;

        // プレイヤーオプションリストを非表示にする
        playerOptions.classList.add('hidden');
      }
    });
  }
}

// 再生条件選択ボタンとオプションのイベントリスナーを設定する関数
function setupConditionSelect() {
  const conditionSelectButton = document.getElementById('condition-select-button');
  const conditionOptions = document.getElementById('condition-options');
  const selectedConditionDisplay = document.getElementById('selected-condition-display');
  const selectedConditionValueField = document.getElementById('selected-condition-value'); // 新しい隠しフィールド

  // 初期リセット処理
  resetSelections();

  if (conditionSelectButton && conditionOptions && selectedConditionDisplay) {
    conditionSelectButton.addEventListener('click', function () {
      document.getElementById('player-options').classList.add('hidden');
      conditionOptions.classList.toggle('hidden');
    });

    conditionOptions.addEventListener('click', function (event) {
      const selectedCondition = event.target.closest('li');
      if (selectedCondition) {
        const conditionLabel = selectedCondition.getAttribute('data-condition-label');
        const conditionValue = selectedCondition.getAttribute('data-condition-value');

        // 隠しフィールドに選択された条件の値をセット
        selectedConditionValueField.value = conditionValue;

        // すべてのチェックアイコンを非表示
        document.querySelectorAll('#condition-options .check-icon').forEach(icon => icon.classList.add('hidden'));

        // 選択された条件にチェックアイコンを表示
        selectedCondition.querySelector('.check-icon').classList.remove('hidden');

        selectedConditionDisplay.innerHTML = `
          <span class="ml-3 block truncate">${conditionLabel}</span>
        `;

        conditionOptions.classList.add('hidden');
      }
    });
  }
}

// 選択状態をリセットする関数
function resetSelections() {
  resetHiddenFields(); // 隠しフィールドの初期化
  resetDisplay(); // 表示リセット用の関数
}

// 隠しフィールドの値をリセットする関数
function resetHiddenFields() {
  const selectedPlayerIdField = document.getElementById('selected-player-id');
  const selectedConditionValueField = document.getElementById('selected-condition-value');

  if (selectedPlayerIdField) {
    selectedPlayerIdField.value = '';
  }

  if (selectedConditionValueField) {
    selectedConditionValueField.value = '';
  }
}

// 表示部分をリセットする関数
function resetDisplay() {
  const selectedPlayerDisplay = document.getElementById('selected-player-display');
  const selectedConditionDisplay = document.getElementById('selected-condition-display');

  if (selectedPlayerDisplay) {
    selectedPlayerDisplay.innerHTML = '<span>未選択</span>';
  }

  if (selectedConditionDisplay) {
    selectedConditionDisplay.innerHTML = '<span>未選択</span>';
  }
}
