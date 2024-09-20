//app/javascript/mypage.js
document.addEventListener("turbo:render", initPlayerForm);
document.addEventListener("turbo:load", initPlayerForm);
document.addEventListener("turbo:frame-load", initPlayerForm);

function initPlayerForm() {
  // ユーザー画像のプレビュー機能を初期化
  const userImageInput = document.getElementById("user_image_input");
  if (userImageInput) {
    userImageInput.addEventListener("change", function(event) {
      const userIconElement = document.querySelector(".user-icon");
      if (userIconElement) {
        previewImage(event, userIconElement);
      }
    });
  }

  // プレイヤー画像のプレビュー機能を初期化
  document.querySelectorAll(".player-card").forEach(function(playerCard) {
    const playerImageInput = playerCard.querySelector("input[type='file']");
    if (playerImageInput) {
      playerImageInput.addEventListener("change", function(event) {
        const playerIconElement = playerCard.querySelector(".player-icon");
        if (playerIconElement) {
          previewImage(event, playerIconElement);
        }
      });
    }

    const removeBtn = playerCard.querySelector(".remove-new-player-btn, .remove-player-btn");
    const destroyFlag = playerCard.querySelector(".destroy-flag");

    if (removeBtn && !removeBtn.dataset.initialized) {
      removeBtn.dataset.initialized = true;
      removeBtn.addEventListener("click", function() {
        if (destroyFlag) {
          destroyFlag.value = "1"; // 既存のプレイヤーの場合はフラグを立てる
          playerCard.style.display = "none";
        } else {
          // 新規プレイヤーの場合はフォームを削除
          playerCard.remove();
        }
      });
    }
  });

  // プレイヤー追加ボタンのイベントリスナー
  const addPlayerBtn = document.getElementById("add-player-btn");
  let playerIndex = document.querySelectorAll(".player-card").length;

  if (addPlayerBtn && !addPlayerBtn.dataset.initialized) {
    addPlayerBtn.dataset.initialized = true;
    addPlayerBtn.addEventListener("click", function() {
      const playerForm = document.createElement("div");
      playerForm.classList.add("player-card", "mt-6", "p-4", "bg-gray-100", "rounded-lg", "flex", "flex-col", "items-center");
      playerForm.innerHTML = `
        <div class="player-details flex-grow">
          <div class="player-icon w-24 h-24 bg-gray-200 rounded-full flex items-center justify-center mr-4 overflow-hidden">
            <span class="text-sm nickname-display">新しいプレイヤー</span>
          </div>
          <div class="form-group">
            <label class="text-sm text-gray-600">プレイヤーネーム</label>
            <input type="text" name="user[players_attributes][${playerIndex}][nickname]" class="form-control block w-48 px-2 py-1 mt-1 border border-gray-300 rounded nickname-input" />
          </div>
          <div class="form-group mt-4">
            <label class="text-sm text-gray-600">誕生日</label>
            <input type="date" name="user[players_attributes][${playerIndex}][birth_date]" class="form-control block w-48 px-2 py-1 mt-1 border border-gray-300 rounded" />
          </div>
          <div class="form-group mt-4">
            <label class="text-sm text-gray-600">性別</label>
            <select name="user[players_attributes][${playerIndex}][gender]" class="form-control block w-48 px-2 py-1 mt-1 border border-gray-300 rounded">
              <option value="male">男の子</option>
              <option value="female">女の子</option>
            </select>
          </div>
          <div class="form-group mt-4">
            <label class="text-sm text-gray-600">プレイヤー画像</label>
            <input type="file" name="user[players_attributes][${playerIndex}][player_image]" class="form-control block w-full px-2 py-1 mt-1 border border-gray-300 rounded player-image-input" />
          </div>
          <input type="hidden" name="user[players_attributes][${playerIndex}][_destroy]" class="destroy-flag" value="0"> <!-- ここで_destroyフィールドを追加 -->
          <button type="button" class="remove-new-player-btn bg-red-500 text-white mt-4 px-3 py-1 rounded">削除</button>
        </div>
      `;
      playersInfoContainer.appendChild(playerForm);
      const nicknameInput = playerForm.querySelector(".nickname-input");
      const nicknameDisplay = playerForm.querySelector(".nickname-display");
      nicknameInput.addEventListener("input", function() {
        nicknameDisplay.textContent = nicknameInput.value || "新しいプレイヤー";
      });

      playerForm.querySelector(".player-image-input").addEventListener("change", function(event) {
        const playerIconElement = playerForm.querySelector(".player-icon");
        if (playerIconElement) {
          previewImage(event, playerIconElement);
        }
      });

      playerForm.querySelector(".remove-new-player-btn").addEventListener("click", function() {
        // 新規プレイヤーの場合はフォームを削除
        playerForm.remove();
      });
      playerIndex++;
    });
  }
}

// 画像プレビュー表示関数
function previewImage(event, targetElement) {
  const file = event.target.files[0];
  if (file) {
    const reader = new FileReader();
    reader.onload = function(e) {
      targetElement.innerHTML = `<img src="${e.target.result}" alt="プレビュー" class="w-full h-full object-cover">`;
    };
    reader.readAsDataURL(file);
  }
}
