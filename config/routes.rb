Rails.application.routes.draw do
  resources :subscriptions do
    get :my_students, on: :collection
    member do
      get :certificate
    end
  end
  get 'users/index'
  # devise_for :users
  devise_for :users, controllers: { registrations: "users/registrations", omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :tags, only: [:create, :index, :destroy]
  resources :courses do
    get :purchased_courses, :pending_reviews,:created_courses, :unapproved_courses, on: :collection
    member do#member means take a course i.e. self
      get :analytics
      patch :approve
      patch :unapprove
    end
    resources :lessons, except: :index do
      resources :comments, except: :index
      put :sort
      member do
        delete :delete_video
      end
    end
    resources :course_wizard, controller: 'courses/course_wizard'
    resources :subscriptions, only: [:new, :create]
  end
  
  resources :youtube, only: :show

  resources :users, only: [:index, :edit, :show, :update]
  get 'home/index'
  get 'activity', to: "home#activity"
  get 'analytics', to: "home#analytics"
  get 'privacy_policy', to: "home#privacy_policy"
  root 'home#index'

  namespace :charts do
    get 'user_per_day'
    get 'subscriptions_per_day'
    get  'course_popularity'
    get  'money_makers'
  end
  # get 'charts/user_per_day', to: "charts#user_per_day"
  # get 'charts/subscriptions_per_day', to: 'charts#subscriptions_per_day' 
  # get 'charts/course_popularity', to: "charts#course_popularity"

end
