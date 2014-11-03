Rails.application.routes.draw do
  resources :ios
  get 'ios/download/:id', to: 'ios#download', as: 'ios_download'

  devise_for :users
  get 'users/chatroom', to: 'users#chatrooms', as: 'user_chatrooms'
  get 'users/:id/messages', to: 'users#messages', as: 'user_messages'
  resources :users

  resources :chatrooms
  resources :messages

  get 'chatrooms/sync/:id', to: 'chatrooms#sync', as: 'sync_messages'
  
  root to: 'visitors#index'
  
  namespace :api do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
      match 'binary/ipa' => 'binary#ipa', :via => :post
      match 'binary/apk' => 'binary#apk', :via => :post
    end
  end



end
