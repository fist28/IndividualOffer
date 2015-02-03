# == Route Map
#
#                 Prefix Verb   URI Pattern              Controller#Action
#       new_user_session GET    /sign_in(.:format)       devise/sessions#new
#           user_session POST   /sign_in(.:format)       devise/sessions#create
#   destroy_user_session DELETE /sign_out(.:format)      devise/sessions#destroy
#          user_password POST   /password(.:format)      devise/passwords#create
#      new_user_password GET    /password/new(.:format)  devise/passwords#new
#     edit_user_password GET    /password/edit(.:format) devise/passwords#edit
#                        PATCH  /password(.:format)      devise/passwords#update
#                        PUT    /password(.:format)      devise/passwords#update
#  new_user_registration GET    /signup(.:format)        devise/registrations#new
#      user_registration POST   /signup(.:format)        devise/registrations#create
#                   root GET    /                        devise/sessions#new
#            application GET    /:user_id(.:format)      dashboard#index {:user_id=>/([0-9]+)/}
# edit_user_registration GET    /:user_id/edit(.:format) devise/registrations#edit {:user_id=>/([0-9]+)/}
#

Rails.application.routes.draw do
  devise_for :users, path: '/', :skip => [:registrations]

  # Devise
  as :user do
    get 'signup' => 'devise/registrations#new', :as => :new_user_registration
    post 'signup' => 'devise/registrations#create', :as => :user_registration
    root 'devise/sessions#new'
  end

  scope ':user_id', user_id: /([0-9]+)/ do
    root to: 'dashboard#index', as: :application

    # Devise
    as :user do
      get 'edit' => 'devise/registrations#edit', as: :edit_user_registration
    end

    resource :company
  end
end
