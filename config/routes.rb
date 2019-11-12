Rails.application.routes.draw do
  root 'projects#index'

  resources :projects
  resources :tasks do
    member do
      post :done

    end
  end

end
