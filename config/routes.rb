Rails.application.routes.draw do
  resources :users

  resource :session, only: [:new, :create, :destroy]

  resources :posts, except: [:index, :new, :create] do
    resources :comments, only: [:new, :create]
  end

  resources :subs do
    resources :posts, only: [:new, :create]
  end

  resources :comments, except: [:new, :index, :create]
  post '/comments/:comment_id', to: 'comments#create_comment', as: "comment_create"

end
