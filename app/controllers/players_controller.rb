class PlayersController < ApplicationController
  before_action :set_players, only: [:switch]

  def switch
    if params[:id]
      @player = current_user.players.find_by(id: params[:id])
      if @player
        session[:current_player_id] = @player.id
        flash[:notice] = "#{@player.nickname}に切り替えました"
        redirect_to mypage_path
      else
        flash[:alert] = "プレイヤーが見つかりません"
      end
    end
    # params[:id]がない場合、このアクションはプレイヤーの選択ページを表示します。
  end

  def player_mypage
    @current_player ||= current_user.players.find_by(id: session[:current_player_id]) # 現在のプレイヤーを取得

    if @current_player.nil?
      flash[:alert] = 'プレイヤーが設定されていません。選択してください。'
      redirect_to switch_players_path
    else
      @play_count = @current_player.results.count # プレイ件数を取得
    end
  end

  private

  def set_players
    @players = current_user.players
  end
end
