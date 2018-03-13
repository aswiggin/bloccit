Rails.application.routes.draw do

  resources :topics do
    # pass resources :posts to resources :topics, this nests the post routs under the topic routes.
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end

  get 'about' => 'welcome#about'
  
  root 'welcome#index'

end
