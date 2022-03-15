Rails.application.routes.draw do
  resources :subscriptions do
    get :my_students, on: :collection
  end
  get 'users/index'
  devise_for :users
  resources :courses do
    get :purchased_courses, :pending_reviews,:created_courses, :unapproved_courses, on: :collection
    member do#member means take a course
      patch :approve
      patch :unapprove
    end
   
    resources :lessons, except: :index
    resources :subscriptions, only: [:new, :create]
  end
  resources :users, only: [:index, :edit, :show, :update]
  get 'home/index'
  get 'activity', to: "home#activity"
  get 'analytics', to: "home#analytics"
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
