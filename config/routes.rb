Rails.application.routes.draw do
  resource :feeds, only: [:new, :show]

  root 'feeds#new'
end
