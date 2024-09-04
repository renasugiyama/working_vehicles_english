class RankingsController < ApplicationController
  # ユーザーがログインしていない場合、ログインページにリダイレクト
  before_action :require_login

  def index
    @players = Player.all.sort_by { |player| player.correct_count.to_i - player.incorrect_count.to_i }.reverse
  end

  def require_login
    unless logged_in?
      flash[:alert] = "ランキングページはログインすると利用できます。"
      redirect_to login_path
    end
  end
end
