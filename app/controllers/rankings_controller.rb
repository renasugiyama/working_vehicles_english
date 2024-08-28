class RankingsController < ApplicationController
  def index
    @players = Player.all.sort_by { |player| player.correct_count.to_i - player.incorrect_count.to_i }.reverse
  end
end
