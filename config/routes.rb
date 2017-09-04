Rails.application.routes.draw do
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  root 'animals#filter'
  resources :users
    get 'show_inventory' => 'animals#show_inventory'
    get 'show_species' => 'animals#show_species'
    get 'show_breed' => 'animals#show_breed'
    get 'show_status' => 'animals#show_status'
  resources :animals do
    get 'change_status_sale' => 'animals#change_status_sale'
    get 'change_status_sold' => 'animals#change_status_sold'
    get 'species' => 'animals#species'
    get 'total_amount_sale' => 'animals#total_amount_sale'
    end
end

