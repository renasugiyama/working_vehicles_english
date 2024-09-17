class ResultsController < ApplicationController
  skip_before_action :require_login, only: [:check, :guest_check]

  def index
    @player = current_user.players.find_by(id: session[:current_player_id])
    @results = @player.results.page(params[:page]).per(10)  # プレイヤーに関連する全ての結果を取得
  end

  def show
    @player = current_user.players.find_by(id: session[:current_player_id])
    @result = @player.results.find(params[:id]).per(10)  # URLから特定の結果を取得
  end

  def correct
    @player = current_user.players.find_by(id: session[:current_player_id])

    if @player
      @player.increment!(:correct_count)

      # 現在の correct_streak が max_streak を超えている場合、max_streak を更新
      if @player.correct_streak > @player.max_streak
        @player.update(max_streak: @player.correct_streak)
      end

      # プレイヤーに適した設定を取得
      setting = PlayerVideoSetting.get_setting_for(@player)

      # エラーハンドリング: settingが存在しない場合はデフォルト値を利用
      play_video_after_correct_count = setting.play_video_after_correct_count || 0

      # 保護者の設定に応じて動画再生フラグを更新
      if play_video_after_correct_count > 0 && @player.correct_streak == play_video_after_correct_count
        @player.update(can_play_video: true, correct_streak: 0) # 正解数が条件に達した場合のみリセット
        redirect_to play_video_prompt_results_path and return
      end
    else
      flash[:alert] = "プレイヤーが見つかりません。"
      redirect_to root_path
    end
  end

  def incorrect
    @player = current_user.players.find_by(id: session[:current_player_id]) 
    
    if @player
      @player.increment!(:incorrect_count)
    end
  end

  def check
    # ログインしていない場合はゲスト用の処理へ
    unless logged_in?
      return guest_check
    end

    # プレイヤーが設定されているか確認
    @player = current_user.players.find_by(id: session[:current_player_id])

    if @player.nil?
      if current_user.players.exists?
        flash[:alert] = "プレイヤーを設定してください。"
        redirect_to players_switch_path and return
      else
        flash[:alert] = "プレイヤーを作成し、プレイヤーの設定を実施してください。"
        redirect_to new_player_path and return
      end
    end

    @choice = Choice.find(params[:id])
    session[:current_question_id] = @choice.question.id  # 質問のIDをセッションに保存
    correct = @choice.is_correct

    begin
      # Resultを保存
      @result = @player.results.create!(
        question: @choice.question,
        choice: @choice,
        correct: correct
      )
    rescue => e
      flash[:error] = "結果の保存に失敗しました: #{e.message}"
      redirect_to root_path and return
    end

    # 正解・不正解の処理の後で `check_answer` を呼び出す
    check_answer(@choice.is_correct)

    if @choice.is_correct
      session[:current_question_id] = nil  # セッションをクリア
      redirect_to correct_results_path
    else
      redirect_to incorrect_results_path
    end
  end

  def guest_check
    @choice = Choice.find(params[:id])
    session[:current_question_id] = @choice.question.id  # 質問のIDをセッションに保存

    if @choice.is_correct
      session[:current_question_id] = nil  # 正解の場合にセッションをクリア
      render 'correct'
    else
      render 'incorrect'
    end
  end

  def check_answer(correct)
    player = current_user.players.find_by(id: session[:current_player_id])

    if correct
      # 正解時のインクリメント
      player.increment!(:correct_streak)
      player.increment!(:total_correct_count)
      player.increment!(:total_answers)
      player.update(incorrect_streak: 0) # 連続不正解数リセット

      # スコープを使用して条件を簡潔に
      if Player.eligible_for_video.exists?(id: player.id)
        player.update(can_play_video: true)
      end

    else
      # 不正解時の処理
      player.update(correct_streak: 0) # 連続正解数リセット
      player.increment!(:incorrect_streak)
      player.increment!(:total_answers)
    end
  
    # プレイ頻度の更新
    update_play_frequency(player)
  
    # リワードの付与チェック
    check_rewards(player)
  end

  # 20問連続正解のメッセージを表示するアクション
  def play_video_prompt
    @player = current_user.players.find_by(id: session[:current_player_id])
  end

  def play_video
    @player = current_user.players.find_by(id: session[:current_player_id])

    # プレイヤー情報の有無チェックと再生権限のチェック
    if @player.nil? || !@player.can_play_video
      flash[:alert] = "動画再生の権限がありません。"
      redirect_to root_path and return
    end

    # 動画再生権限を使用後にフラグをリセット
    session[:video_played] ||= false
    if session[:video_played]
      session.delete(:video_played) # リロードでリセット
    else
      session[:video_played] = true
      @player.update(can_play_video: false)
    end

    # 再生のトラッキングを保存
    VideoPlayback.create(player: @player, played_at: Time.current)

    # 直接play_video.html.erbを表示
    render :play_video
  end

  def reset_flag
    @player = current_user.players.find_by(id: session[:current_player_id])
    if @player
      @player.update(can_play_video: false)
      render json: { message: 'Flag reset successfully' }, status: :ok
    else
      render json: { error: 'Player not found' }, status: :unprocessable_entity
    end
  end

  private

  # プレイ頻度の更新メソッド
  def update_play_frequency(player)
    # 最後にプレイした日付が今日より前であれば、連続日数をインクリメント
    if player.last_played_at.nil? || player.last_played_at.to_date < Date.today
      player.increment!(:daily_play_count)
      player.update(last_played_at: Time.current)
    else
      player.update(last_played_at: Time.current) # 今日すでにプレイしている場合は日付のみ更新
    end
  end

  # リワードのチェックメソッド
  def check_rewards(player)
    Reward.all.each do |reward|
      if reward.achieved?(player) && !player.rewards.include?(reward)
        player.rewards << reward
        flash[:notice] = "リワードを獲得しました！"
      end
    end
  end
end
