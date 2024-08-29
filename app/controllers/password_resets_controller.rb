class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    not_authenticated if @user.blank?
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
	    @user.deliver_reset_password_instructions!

	    redirect_to login_path, notice: 'パスワードリセット用のメールを送信しました。'
	  else
      flash[:alert] = "メールアドレスが見つかりません"
      render :new
    end
	end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
  
    return not_authenticated if @user.blank?
  
    if params[:user].present?
      # パスワードと確認パスワードを設定
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      
      # Sorceryのメソッドを使わずにバリデーションをチェック
      if @user.password.present? && @user.password_confirmation.present? && @user.valid?
        # Sorceryのchange_passwordメソッドを使ってパスワードを変更
        if @user.change_password(params[:user][:password])
          redirect_to login_path, notice: 'パスワードが再設定されました。'
        else
          flash.now[:alert] = 'パスワードの再設定に失敗しました。入力内容を確認してください。'
          render :edit
        end
      else
        flash.now[:alert] = "入力内容に誤りがあります。" + @user.errors.full_messages.join(", ")
        render :edit
      end
    else
      flash.now[:alert] = '入力内容に誤りがあります。'
      render :edit
    end
  end  
end
