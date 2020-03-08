Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :api do
    collection {get :activities}
    collection {get :babies}
    collection {post :activity_logs}
  end

  get 'api/babies/:id/activity_logs' => 'api#activity_log'
  get 'api/babies/:id' => 'api#show_baby'
  put 'api/activity_logs/:id' => 'api#update_activity'
  get 'api/activity_logs' => 'api#all_activity_logs'



end
