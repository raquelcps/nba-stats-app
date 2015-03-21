Rails.application.routes.draw do
  
  get '/statistics' => 'statistics#index'
  get '/vis' => 'statistics#vistest'

end
