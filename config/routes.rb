Rails.application.routes.draw do
  get 'feed', to: 'home#feed'
  root 'home#welcome'
end
