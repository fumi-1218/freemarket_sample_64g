Rails.application.routes.draw do
  root to: 'index#index'
  devise_for :users,
  controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
    resources :signup do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4' # ここで、入力の全てが終了する
      get 'done' # 登録完了後のページ
    end
  end
  resources :card, only: [:index, :new, :show, :delete] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end
  resources :users, only: [:index,:show,:new, :edit]

  resources :mypage, only: [:index] do
    get "profile"
  end
  resources :items, only: [:index,:show,:edit,:update,:destroy] do
    collection do
      get 'chenge_item'
    end
  end
  resources :logout, only: [:index]
  resources :sell, only: [:index,:new, :create, :destroy]
  resources :items, only: [:index,:show,:edit,:destroy]
  resources :profile, only: [:index]
  resources :card, only: [:index] do
    collection do
      get 'mypage_card_input'
    end
  end
  resources :pribate, only: [:index]
  resources :confomation, only: [:index]
  
  get '/mypage/notification', to: 'mypage#notification'
  get '/mypage/todo', to: 'mypage#todo'
  get '/mypage/card', to: 'mypage#card'
  get '/mypage/deliver_address', to: 'mypage#deliver_address'
  delete '/card/delete', to: 'card#delete'



end
