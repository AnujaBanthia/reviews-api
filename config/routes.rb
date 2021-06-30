Rails.application.routes.draw do
    #books
    resources :books, only: [:create, :index, :update, :destroy, :show], path: '/admin/books'

    #movies
    resources :movies, only: [:create, :index, :update, :destroy, :show], path: '/admin/movies'

    #reviews
    resources :books, :movies,  only: [:index,:show] do
      resources :reviews, only: [:create, :index, :update, :destroy, :show]
    end
    
    resources :users, only: [:show] do
      resources :reviews, only: [:index]
    end

    #user profile
    get 'profile', action: :show, controller: 'users'


    #comments
    resources :reviews, only: [:show] do
      resources :comments
    end

    #login
    post 'login', to: 'sessions#create'

    #logout
    delete 'logout', to: 'sessions#destroy'
end
