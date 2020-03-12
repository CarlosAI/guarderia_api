Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :api do
    collection {get :activities}
    collection {get :babies}
    collection {post :activity_logs}
    collection {get :all_activity_logs}
    collection {get :assistants}
  end

  get 'api/babies/:id/activity_logs' => 'api#activity_log'
  get 'api/babies/:id' => 'api#show_baby'
  put 'api/activity_logs/:id' => 'api#update_activity'
  # get 'api/all_activity_logs' => 'api#all_activity_logs'



end
