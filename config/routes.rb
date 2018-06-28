 Rails.application.routes.draw do

  root 'users#index'
  get 'users/index'

  post 'users' => 'users#create'

  post 'sessions' => 'sessions#create'
  delete 'sessions/:id' => 'sessions#destroy'
  #somethig
  get 'groups/index'
  get 'groups' => 'groups#index'
  post 'groups' => 'groups#create'
  get 'groups/:id' => 'groups#show'
  delete 'groups/:id' => 'groups#destroy'

  post 'joins/:id' => 'groups#joins'
  delete 'joins/:id' => 'groups#leave'

end
