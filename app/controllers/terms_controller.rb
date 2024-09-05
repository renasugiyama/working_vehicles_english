class TermsController < ApplicationController
  skip_before_action :require_login, only: [:show, :agree, :terms_page, :privacy] # 利用規約ページではログインをスキップ

  def show; end

  def terms_page; end

  def privacy; end

  def agree
    session[:agreed_to_terms] = true
    redirect_to random_question_path # ランダムな質問ページのパスに変更
  end
end
