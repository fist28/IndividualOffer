# == Route Map
#
#                 Prefix Verb   URI Pattern                    Controller#Action
#          user_password POST   /users/password(.:format)      devise/passwords#create
#      new_user_password GET    /users/password/new(.:format)  devise/passwords#new
#     edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
#                        PATCH  /users/password(.:format)      devise/passwords#update
#                        PUT    /users/password(.:format)      devise/passwords#update
#       new_user_session GET    /signin(.:format)              devise/sessions#new
#           user_session POST   /signin(.:format)              devise/sessions#create
#   destroy_user_session DELETE /signout(.:format)             devise/sessions#destroy
#                   root GET    /                              devise/sessions#new
#            application GET    /:user_id(.:format)            dashboard#index {:user_id=>/([0-9]+)/}
# edit_user_registration GET    /:user_id/users/edit(.:format) devise/registrations#edit {:user_id=>/([0-9]+)/}
#      user_registration PUT    /:user_id/users/:id(.:format)  devise/registrations#update {:user_id=>/([0-9]+)/}
#

Rails.application.routes.draw do
  devise_for :users, :skip => [:sessions, :registrations]
  # Devise
  as :user do
    get 'signin' => 'devise/sessions#new', as: :new_user_session
    post 'signin' => 'devise/sessions#create', as: :user_session
    match 'signout' => 'devise/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
    root 'devise/sessions#new'
  end

  scope ':user_id', user_id: /([0-9]+)/ do
    root to: 'dashboard#index', as: :application

    # Devise
    as :user do
      get 'users/edit' => 'devise/registrations#edit', as: :edit_user_registration
      put 'users/:id' => 'devise/registrations#update', as: :user_registration
    end
  end
end
