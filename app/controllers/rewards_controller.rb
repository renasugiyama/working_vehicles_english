class RewardsController < ApplicationController
  def index
    @current_player ||= current_user.players.find_by(id: session[:current_player_id])
    @rewards = Reward.all.map do |reward|
      achieved = @current_player.rewards.include?(reward)
      # 達成状況に応じてアイコンパスを切り替え
      icon_path = achieved ? "#{reward.icon}_color.png" : "#{reward.icon}_gray.png"
      {
        reward: reward,
        achieved: achieved,
        icon: icon_path
      }
    end
  end

  # 全プレイヤーを表示するアクション
  def players
    @players = current_user.players # ログインしているユーザーの全プレイヤーを取得
  end

  # 特定のプレイヤーのRewardを表示するアクション
  def player_rewards
    @player = current_user.players.find(params[:id]) # URLのIDに基づいてプレイヤーを取得
    @rewards = Reward.all.map do |reward|
      achieved = @player.rewards.include?(reward)
      # 達成状況に応じてアイコンパスを切り替え
      icon_path = achieved ? "#{reward.icon}_color.png" : "#{reward.icon}_gray.png"
      {
        reward: reward,
        achieved: achieved,
        icon: icon_path
      }
    end
  end
end
