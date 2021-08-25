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
   end
  end
end
