Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/business/fetch_reviews/:name', to: 'business#fetch_reviews'

end
