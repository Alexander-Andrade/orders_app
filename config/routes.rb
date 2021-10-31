Rails.application.routes.draw do

  namespace :api do
    namespace :bookings do
      resources :orders, only: %i[create update]
    end
  end
end
