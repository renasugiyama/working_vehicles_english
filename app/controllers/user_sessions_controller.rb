class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to switch_players_path, notice: 'ログインに成功しました。プレイヤーを設定してゲームをスタートしてください'
    else
      flash.now[:alert] = 'ログインに失敗しました'
      flash.now[:errors] = 'メールアドレスまたはパスワードが間違っています'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:alert] = 'ログアウトしました'
    redirect_to root_path, status: :see_other
  end
end
