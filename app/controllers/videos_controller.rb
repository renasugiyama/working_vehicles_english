class VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :check_video_permission

  def show
    # 再生権限をリセットして再度の再生を制限
    @player.update(can_play_video: false)

    # 動画のパスを指定
    video_path = Rails.root.join("protected_videos", "your_video.mp4")
    send_file video_path, type: 'video/mp4', disposition: 'inline'
  end
  
	private

  def check_video_permission
    @player = current_user.players.find_by(id: session[:current_player_id])
    unless @player && @player.can_play_video
      flash[:alert] = "動画の再生は連続で10問正解した人だけの特典です。再生可能な回数は1度だけです。"
      redirect_to root_path
    end
  end
end
