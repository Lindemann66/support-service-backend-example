Rails.application.routes.draw do
  scope 'api', defaults: {format: 'json'}, module: 'api' do
    def params_for(command, ext = {})
      [
        command,
        {
          command: command.to_s,
          controller: 'api',
        }.merge(ext)
      ]
    end

    resource(*params_for(:session, only: [:create]))
    resource(*params_for(:user, only: [:show, :create]))
    scope 'user' do
      resources(*params_for(:requests, only: [:index, :show, :create]))
    end

    resource 'user' do
      post 'destroy_user', to: 'api#api_response', command: :user
      get 'managed_users', to: 'api#api_response', command: :user

      namespace 'requests' do
        get 'search', to: 'api#search'
      end

      resources :requests, only: [] do
        member do 
          post 'update_request', to: 'api#api_response', command: :requests
          post 'destroy_request', to: 'api#api_response', command: :requests
        end
      end
    end

    resource 'session' do
      post 'destroy_session', to: 'api#api_response', command: :session
    end
  end
end
