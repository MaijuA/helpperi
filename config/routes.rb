Rails.application.routes.draw do

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  resources :categories
  devise_for :users, :controllers => {:registrations => "registrations",
             :omniauth_callbacks => "omniauth_callbacks" }

  resources :users, only: [:show, :index, :list]

  resources :posts

  resources :ratings, only: :create

  root 'posts#index'

  get '/search', to:'posts#search', as: :search

  resources :posts do
    post 'delete_post'
    post 'add_candidate'
    post 'deny_candidate'
    post 'accept_candidate'
  end

  get '/review', to:'users#review', as: :user_review
  get '/ratings', to:'users#ratings', as: :user_ratings
  get '/history', to:'users#history', as: :user_history

  # resources :users do
  #   post 'create_rating'
  # end

  post 'users/create_rating', to:'users#create_rating', as: :users_create_rating

  get '/interests' => 'users#interests', as: :user_interests
  get '/list' => 'admin#list', as: :admin_list

  get '/info' => 'info#info', as: :info_info
  get '/contact' => 'info#contact', as: :info_contact
  get '/cooperation' => 'info#cooperation', as: :info_cooperation

  #resources :contact, only: [:index]

  #resources :cooperation, only: [:index]

  #resources :info, only: [:index]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
