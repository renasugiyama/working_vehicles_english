class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: [:setting, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)  # 新しいユーザーを自動的にログインさせる
      redirect_to switch_players_path, notice: 'ユーザー登録が完了しました。プレイヤーを作成して、ゲームをスタートしてください。また、設定リンクから各プレイヤーの動画再生設定が可能です。'
    else
      flash.now[:alert] = 'ユーザー登録に失敗しました'
      flash.now[:errors] = @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def setting
    # セッションが存在する場合のみリセット
    if session[:pin_code_verified].present?
      session[:pin_code_verified] = nil
    end
  end

  def pin_code; end
  
  def set_pin_code;  end

  def reset_pin_code; end

  def validate_pin_code
    # 現在のユーザーのPINコードと照合
    if current_user.pin_code == params[:pin_code]
      session[:pin_code_verified] = true # PINコード確認済みフラグを設定
      Rails.logger.debug("PINコード認証成功: セッションは #{session[:pin_code_verified]}")
      redirect_to player_video_settings_path, notice: "正しいPINコードが入力されました。"
    else
      flash[:alert] = "PINコードが間違っています。"
      render :pin_code
    end
  end

  def create_pin_code
    # 入力されたメールアドレスと現在のユーザーのメールアドレスを照合
    if params[:email] == current_user.email
      if params[:pin_code].present?
        current_user.update(pin_code: params[:pin_code])
        # セッションにフラグを設定して、次回のアクセスでPINコードをスキップ
        session[:pin_code_just_set] = true
        redirect_to player_video_settings_path, notice: "PINコードが設定されました。"
      else
        flash[:alert] = "PINコードを入力してください。"
        render :set_pin_code
      end
    else
      flash[:alert] = "メールアドレスが一致しません。"
      render :set_pin_code
    end
  end

  def update_pin_code
    if params[:email] == current_user.email
      if params[:pin_code].present?
        current_user.update(pin_code: params[:pin_code])
        # PINコードを更新した直後は、次回アクセスで確認をスキップ
        session[:pin_code_just_set] = true
        redirect_to player_video_settings_path, notice: "PINコードが更新されました。"
      else
        flash[:alert] = "PINコードを入力してください。"
        render :reset_pin_code
      end
    else
      flash[:alert] = "メールアドレスが一致しません。"
      render :reset_pin_code
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'ユーザーが削除されました。'
  end

  def edit_email
    @user = current_user
  end

  def update_email
    @user = current_user
    @user.current_password = params[:user][:current_password]  # フォームから送信された現在のパスワードを設定
    new_email = params[:user][:email]

    # パスワードが空の場合のチェック
    if @user.current_password.blank?
      @user.errors.add(:base, "パスワードを入力してください。")
    end

    # 新しいメールアドレスが空の場合のチェック
    if new_email.blank?
      @user.errors.add(:base, "新しいメールアドレスを入力してください。")
    end

    # エラーがある場合は終了
    if @user.errors.any?
      flash.now[:alert] = @user.errors.full_messages.join("<br>")
      render :edit_email and return
    end
  
    if new_email != @user.email && new_email.present?
      @user.unconfirmed_email = new_email
      @user.confirmation_token = SecureRandom.hex(10)
      @user.confirmation_sent_at = Time.current

      if @user.save
        UserMailer.email_change_confirmation(@user).deliver_now
        flash[:notice] = "確認メールを新しいメールアドレスに送信しました。メール内のリンクをクリックして確認を完了してください。"
        redirect_to user_setting_path
      else
        flash.now[:alert] = @user.errors.full_messages.join(", ")
        render :edit_email
      end
    else
      flash.now[:alert] = "新しいメールアドレスを入力してください。"
      render :edit_email
    end
  end

  def confirm_email_change
    @user = User.find_by(confirmation_token: params[:token])

    if @user && @user.confirmation_token_valid?
      @user.email = @user.unconfirmed_email
      @user.unconfirmed_email = nil
      @user.confirmation_token = nil
      @user.save
      flash[:notice] = "メールアドレスが確認されました。"
      redirect_to user_setting_path
    else
      flash[:alert] = "リンクが無効または期限切れです。"
      redirect_to user_setting_path
    end
  end

  private

  def set_user
    @user = current_user
  end  

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_image, :terms_agreement, :privacy_policy_agreement)
  end

  def user_email_params
    params.require(:user).permit(:email)
  end
end
