Rails.application.routes.draw do
  resources :topics do
    # pass resources :posts to resources :topics, this nests the post routs under the topic routes.
    resources :posts, except: [:index]
  end
  
  resources :users, only: [:new, :create]
  post 'users/confirm' => 'users#confirm'

  get 'about' => 'welcome#about'
  
  root 'welcome#index'

end
