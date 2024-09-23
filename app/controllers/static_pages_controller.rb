class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top contact]
  
  def top
    # セッションが存在する場合のみリセット
    if session[:pin_code_verified].present?
      session[:pin_code_verified] = nil
    end
  end

  def contact; end
end
