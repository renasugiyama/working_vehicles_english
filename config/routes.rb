Rails.application.routes.draw do
  get 'rankings', to: 'rankings#index', as: 'rankings'
  get 'static_pages/top'
  root 'static_pages#top'

  resources :users, only: %i[new create edit update destroy setting] do
    member do
      get 'edit_email'
      patch 'update_email'
      get 'confirm_email_change'
    end
  end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'setting', to: 'users#setting', as: :user_setting

  resources :password_resets, only: %i[new create edit update]

  resources :questions, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  get 'random_question', to: 'questions#random', as: 'random_question'

  resources :results, only: [] do
    member do
      get 'check'
      get :guest_check
    end
  end
  
  resources :mypages, only: [:edit, :update, :show, :destroy] do
    resources :players, only: [:new, :create, :edit, :update, :destroy, :show]
    delete :reset_user_image, on: :collection
    delete :reset_player_image, on: :collection
  end

  get 'mypage/display', to: 'mypages#display', as: 'mypage_display'

  resources :players, only: [:create, :update, :destroy] do
    member do
      post 'switch'  # プレイヤーを切り替えるアクション
    end
    collection do
      get 'switch'  # プレイヤー選択ページの表示
    end
  end

  get 'players/player_mypage', to: 'players#player_mypage', as: 'player_mypage_players'

  resources :players do
    resources :results, only: [:create, :index, :show] do
      member do
        get 'check'
      end
    end
  end

  # correct と incorrect アクションのルーティングを追加
  get 'results/correct', to: 'results#correct', as: 'correct_results'
  get 'results/incorrect', to: 'results#incorrect', as: 'incorrect_results'

  get 'terms', to: 'terms#show'
  post 'terms/agree', to: 'terms#agree', as: 'agree_terms'
  get 'terms/page', to: 'terms#terms_page', as: 'terms_page'
  get 'terms/privacy', to: 'terms#privacy', as: 'privacy_terms'

  get 'contact', to: 'static_pages#contact', as: 'contact'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
