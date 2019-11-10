Rails.application.routes.draw do
  root 'projects#index'

  resource :projects
end
