Rails.application.routes.draw do
  
  get '/statistics' => 'statistics#index'
  get '/player' => 'statistics#player'
  get '/team' => 'statistics#team'

end
