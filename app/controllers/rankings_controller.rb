class RankingsController < ApplicationController
  # ユーザーがログインしていない場合、ログインページにリダイレクト
  before_action :require_login

  def index
    # セッションが存在する場合のみリセット
    if session[:pin_code_verified].present?
      session[:pin_code_verified] = nil
    end
    # すべてのプレイヤーを取得し、正解数と不正解数の差に基づいてソート
    sorted_players = Player.all.sort_by { |player| player.correct_count.to_i - player.incorrect_count.to_i }.reverse
  
    # ソートされたプレイヤーの配列にページネーションを適用
    @players = Kaminari.paginate_array(sorted_players).page(params[:page]).per(10) # 1ページあたり10件表示
  end  

  def require_login
    unless logged_in?
      flash[:alert] = "ランキングページはログインすると利用できます。"
      redirect_to login_path
    end
  end
end
