class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    
    # Googleからのエラーパラメータ
    if params[:error].present?
      redirect_to root_path, alert: "Login failed: #{params[:error_description]}"
      return
    end

    # 必要なパラメータが存在するか
    unless params[:code].present?
      redirect_to root_path, alert: "Login failed: Missing authorization code."
      return
    end

    # 認証処理
    if @user = login_from(provider)
      redirect_to root_path, notice: "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to root_path, notice: "Logged in from #{provider.titleize}!"
      rescue => e
        redirect_to root_path, alert: "Failed to login from #{provider.titleize}!"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :error_description)
  end
end
