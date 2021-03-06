Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create,:new, :edit, :update] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    resources :listings, except: [:index, :show, :destroy] do
      resources :reservations, except: [:index]
    end
    resources :reservations, only: [:index]
  end

  resources :listings, only: [:index, :show, :destroy]


  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:"welcome#show"

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  put "/updaterole" => "users#become_host", as: "bhost"

  get "/verifylistings" => "listings#verify_page"

  put "/verified" => "listings#verified", as: "verified"

end
