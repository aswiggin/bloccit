Rails.application.routes.draw do
  resources :topics do
    # pass resources :posts to resources :topics, this nests the post routs under the topic routes.
    resources :posts, except: [:index]
  end
  
  resources :posts, only: [] do
    # only need routes for these two actions since comments will be viewed on a posts show view
    resources :comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'
  
  root 'welcome#index'

end
