Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show]
    end
  end
  post '/getflights', to: 'flights#getflights'
  get '/getflights', to: 'flights#retrieveflights'
end
