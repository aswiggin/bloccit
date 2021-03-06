Rails.application.routes.draw do
  resources :topics do
    # pass resources :posts to resources :topics, this nests the post routs under the topic routes.
    resources :posts, except: [:index]
  end
  
  resources :posts, only: [] do
    # only need routes for these two actions since comments will be viewed on a posts show view
    resources :comments, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end
  
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]

  get 'about' => 'welcome#about'
  
  root 'welcome#index'

end
