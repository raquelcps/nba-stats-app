Rails.application.routes.draw do
  
  get '/statistics' => 'statistics#index'
  get '/leadersmonthly' => 'statistics#leadersmonthly'
  get '/player' => 'statistics#player'
  get '/player/assists' => 'statistics#playerassists'
  get '/player/passes' => 'statistics#playerpasses'
  get '/player/actions'
  get 'player/teamoverview' => 'statistics#teamoverview'
  get '/team' => 'statistics#team'

end
