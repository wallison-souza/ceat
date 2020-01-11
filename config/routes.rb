Rails.application.routes.draw do
  resources :salas
  resources :presencas do
    collection do
      get 'lists_normals'
      get 'lists_priority'
      get 'list_red'
      get 'list_blue'
      get 'list_first_time'
      get 'list_priority'
      get 'pacientes'
    end
  end
  devise_for :usuarios
  resources :pacientes
  root :to => "application#home"

  # route for search city by state
  get "/cities_by_state" => "cidades#cities_by_state"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
