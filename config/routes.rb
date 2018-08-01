Rails.application.routes.draw do
  namespace :api do
    resource :session, only:[:create] do
      post :destroy_session # it should be just :destroy, but cors
    end
    resource :user, only:[:show, :index, :create] do
      post :destroy_user # also
      get :managed_users
      resources :requests, only: [:show, :index, :create] do
        collection do
          get :search
        end
        member do
          get :as_pdf
          post :update_request # :update
          post :destroy_request # :destroy
        end
      end
    end
  end
end
