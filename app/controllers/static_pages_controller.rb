class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top contact]
  
  def top;  end

  def contact; end
end
