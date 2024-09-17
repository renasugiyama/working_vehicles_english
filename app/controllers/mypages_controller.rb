class MypagesController < ApplicationController
  before_action :set_user, only: [:display, :edit, :update, :reset_player_image]

  def display
    @user = current_user
    @players = @user.players.includes(:player_video_setting) # プレイヤーと再生設定を一緒に取得
  end

  def edit
    @players = @user.players
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_display_path, notice: 'マイページが更新されました'
    else
      flash.now[:alert] = 'マイページの更新に失敗しました'
      flash.now[:errors] = @user.errors.full_messages.map { |msg| "#{msg}" }

      # エラー時に削除したプレイヤーが表示されないようにするために、削除フラグが1になっているプレイヤーを除外
      @players = @user.players.reject { |player| player._destroy == '1' }

      render :edit, status: :unprocessable_entity
    end
  end

  def reset_user_image
    @user = current_user
    @user.remove_user_image!  # CarrierWaveの画像を削除
    if @user.save
      redirect_to edit_mypage_path(@user)
    else
      redirect_to edit_mypage_path(@user), alert: 'プロフィール画像のリセットに失敗しました'
    end
  end

  def reset_player_image
    @player = Player.find(params[:player_id])
    @player.remove_player_image!  # CarrierWaveの画像を削除
    if @player.save
      redirect_to edit_mypage_path(@user)
    else
      redirect_to edit_mypage_path(@user), alert: 'プレイヤー画像のリセットに失敗しました'
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :user_image, players_attributes: [:id, :nickname, :birth_date, :gender, :player_image, :_destroy])
  end
end
