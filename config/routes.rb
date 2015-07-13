Rails.application.routes.draw do
  root to: "search#index"

  namespace :api do
    namespace :v1 do
      get "/search", to: "search#index"
    end
  end

  get "/search", to: "search#index"
end
