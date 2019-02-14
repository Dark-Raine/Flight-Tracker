Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show]
    end
  end
  post '/getflights', to: 'flights#getflights', as: 'getflights_session'
  get '/getflights', to: 'flights#retrieveflights', as: 'getflights_results'
end
