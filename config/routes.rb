Gtest::Application.routes.draw do

  resource :authentications, :only => [:destroy]
  resources :users do
    resources :comments, :controller => 'users/comments', :only => [:create]
    resources :albums, :controller => 'users/albums', :only => [:index] do
      collection do
        get :show_album
      end
    end
  end

  match '/auth/:provider/callback' => 'authentications#create'
  match '/album/:picture_id/fetch_comments' => 'users/comments#index'
  root :to => 'pages#index'

end
