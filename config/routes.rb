Rails.application.routes.draw do
  #get 'sessions/new'

  ##get 'static_pages/top'
  root 'static_pages#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/signup', to: 'users#new'
  
  ## ログイン機能(6.1 最初に実装するnewアクションを指定して生成)
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  ## 9.3.1 モーダルウインドウを表示  
  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      ## 11.1 勤怠編集ページの作成し、ルーティングを設定
      get 'attendances/edit_one_month'
      ## 11.1.4 勤怠編集ページの更新ボタン作成
      patch 'attendances/update_one_month'
    end
    ##10.5.1 ルーティングを設定/出勤登録ボタン
    resources :attendances, only: :update
  end
end
