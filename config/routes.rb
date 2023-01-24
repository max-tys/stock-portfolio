Rails.application.routes.draw do
  root 'portfolios#index'

  resources :portfolios do
    resources :holdings, except: %i[index edit update], shallow: true do
      resources :transactions, except: %i[index show], shallow: true
    end
  end
end
