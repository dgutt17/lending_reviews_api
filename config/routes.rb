Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/lending_tree/fetch_reviews/', to: 'lending_tree#fetch_reviews'

end
