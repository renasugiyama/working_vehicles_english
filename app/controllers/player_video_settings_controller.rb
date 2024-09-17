class PlayerVideoSettingsController < ApplicationController
  def new
    @player_video_setting = PlayerVideoSetting.new
  end

  def index; end

  def create
    # グローバル設定が有効かつplayer_idが空の場合、全プレイヤーの設定を更新
    if player_video_setting_params[:is_global] == "true" && player_video_setting_params[:player_id].blank?
      update_global_settings
    else
      # 個別のプレイヤー設定を新規作成
      @player_video_setting = PlayerVideoSetting.new(player_video_setting_params)

      if @player_video_setting.save
        flash[:notice] = '設定が保存されました。'
        # Turboの影響を排除
        respond_to do |format|
          format.html { redirect_to new_player_video_setting_path }
          format.turbo_stream { render turbo_stream: turbo_stream.replace('flash', partial: 'shared/flash_message') }
        end
      else
        flash.now[:alert] = @player_video_setting.errors.full_messages.join("\n")
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
    if player_video_setting_params[:is_global] == "true" && player_video_setting_params[:player_id].blank?
      # 全体設定の場合、既存の設定を更新
      update_global_settings
    else
      # 個別のプレイヤー設定を更新
      @player_video_setting = PlayerVideoSetting.find(params[:id])

      if @player_video_setting.update(player_video_setting_params)
        flash[:notice] = '設定が更新されました。'
        redirect_to new_player_video_setting_path
      else
        # エラー時にフォームの値をリセット
        @player_video_setting = PlayerVideoSetting.new
        flash.now[:alert] = @player_video_setting.errors.full_messages.join("\n")
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  # 全体設定を更新するメソッド
  def update_global_settings
    # play_video_after_correct_countがnilまたは空の場合にエラーメッセージを表示
    if player_video_setting_params[:play_video_after_correct_count].blank?
      flash.now[:alert] = '再生条件を選択してください。'
      render :new, status: :unprocessable_entity
      return
    end

    PlayerVideoSetting.transaction do
      current_user.players.each do |player|
        # プレイヤーごとの設定を初期化または更新
        setting = PlayerVideoSetting.find_or_initialize_by(player_id: player.id)

        # 必要な属性を設定し、player_idはplayerのIDに明示的に設定
        setting.player_id = player.id

        unless setting.update(play_video_after_correct_count: player_video_setting_params[:play_video_after_correct_count])
          Rails.logger.error("Failed to update setting for player #{player.id}: #{setting.errors.full_messages.join(', ')}")
          flash.now[:alert] = "プレイヤー名:#{player.nickname} の設定更新に失敗しました。<br> #{setting.errors.full_messages.join(', ')}"
          raise ActiveRecord::Rollback # エラーが発生した場合、ロールバックする
        else
          Rails.logger.info("Successfully updated setting for player #{player.id}: #{setting.inspect}")
        end
      end
    end
    flash[:notice] = '全プレイヤーの設定が更新されました。'
    redirect_to new_player_video_setting_path
	rescue ActiveRecord::Rollback
	  # ロールバックが発生した場合の処理
	  render :new, status: :unprocessable_entity
	end

  def player_video_setting_params
    params.require(:player_video_setting).permit(:player_id, :play_video_after_correct_count, :is_global)
  end
end
