Rails.application.routes.draw do
  get 'rankings', to: 'rankings#index', as: 'rankings'
  get 'static_pages/top'
  root 'static_pages#top'

  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :questions, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  get 'random_question', to: 'questions#random', as: 'random_question'

  resources :results, only: [] do
    member do
      get 'check'
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
end
