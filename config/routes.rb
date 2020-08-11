Rails.application.routes.draw do
  root 'items#new'

  resources :items, only: [:index,:new,:create] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end


end


