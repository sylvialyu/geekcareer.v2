Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :jobs do

    put :favorite, on: :member
    
    resources :resumes

    collection do
      get :search
    end

  end

  resources :favorites

  resources :job_relationships

  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end
  end

  root "welcome#index"
end
