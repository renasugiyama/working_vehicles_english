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
end
