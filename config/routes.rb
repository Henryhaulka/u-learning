Rails.application.routes.draw do
  resources :subscriptions do
    get :my_students, on: :collection
  end
  get 'users/index'
  devise_for :users
  resources :courses do
    get :purchased_courses, :pending_reviews,:created_courses, on: :collection
    resources :lessons, except: :index
    resources :subscriptions, only: [:new, :create]
  end
  resources :users, only: [:index, :edit, :show, :update]
  get 'home/index'
  get 'home/activity'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
