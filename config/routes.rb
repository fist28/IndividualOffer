# == Route Map
#
#                     Prefix Verb   URI Pattern                                                              Controller#Action
#           new_user_session GET    /sign_in(.:format)                                                       devise/sessions#new
#               user_session POST   /sign_in(.:format)                                                       devise/sessions#create
#       destroy_user_session DELETE /sign_out(.:format)                                                      devise/sessions#destroy
#              user_password POST   /password(.:format)                                                      devise/passwords#create
#          new_user_password GET    /password/new(.:format)                                                  devise/passwords#new
#         edit_user_password GET    /password/edit(.:format)                                                 devise/passwords#edit
#                            PATCH  /password(.:format)                                                      devise/passwords#update
#                            PUT    /password(.:format)                                                      devise/passwords#update
#      new_user_registration GET    /signup(.:format)                                                        devise/registrations#new
#          user_registration POST   /signup(.:format)                                                        devise/registrations#create
#                       root GET    /                                                                        devise/sessions#new
#                application GET    /:user_id(.:format)                                                      dashboard#index {:user_id=>/([0-9]+)/}
#     edit_user_registration GET    /:user_id/edit(.:format)                                                 devise/registrations#edit {:user_id=>/([0-9]+)/}
# company_client_offer_index GET    /:user_id/company/:company_id/client/:client_id/offer(.:format)          offer#index {:user_id=>/([0-9]+)/}
#                            POST   /:user_id/company/:company_id/client/:client_id/offer(.:format)          offer#create {:user_id=>/([0-9]+)/}
#   new_company_client_offer GET    /:user_id/company/:company_id/client/:client_id/offer/new(.:format)      offer#new {:user_id=>/([0-9]+)/}
#  edit_company_client_offer GET    /:user_id/company/:company_id/client/:client_id/offer/:id/edit(.:format) offer#edit {:user_id=>/([0-9]+)/}
#       company_client_offer GET    /:user_id/company/:company_id/client/:client_id/offer/:id(.:format)      offer#show {:user_id=>/([0-9]+)/}
#                            PATCH  /:user_id/company/:company_id/client/:client_id/offer/:id(.:format)      offer#update {:user_id=>/([0-9]+)/}
#                            PUT    /:user_id/company/:company_id/client/:client_id/offer/:id(.:format)      offer#update {:user_id=>/([0-9]+)/}
#                            DELETE /:user_id/company/:company_id/client/:client_id/offer/:id(.:format)      offer#destroy {:user_id=>/([0-9]+)/}
#       company_client_index GET    /:user_id/company/:company_id/client(.:format)                           client#index {:user_id=>/([0-9]+)/}
#                            POST   /:user_id/company/:company_id/client(.:format)                           client#create {:user_id=>/([0-9]+)/}
#         new_company_client GET    /:user_id/company/:company_id/client/new(.:format)                       client#new {:user_id=>/([0-9]+)/}
#        edit_company_client GET    /:user_id/company/:company_id/client/:id/edit(.:format)                  client#edit {:user_id=>/([0-9]+)/}
#             company_client GET    /:user_id/company/:company_id/client/:id(.:format)                       client#show {:user_id=>/([0-9]+)/}
#                            PATCH  /:user_id/company/:company_id/client/:id(.:format)                       client#update {:user_id=>/([0-9]+)/}
#                            PUT    /:user_id/company/:company_id/client/:id(.:format)                       client#update {:user_id=>/([0-9]+)/}
#                            DELETE /:user_id/company/:company_id/client/:id(.:format)                       client#destroy {:user_id=>/([0-9]+)/}
#                    company GET    /:user_id/company/:id(.:format)                                          company#show {:user_id=>/([0-9]+)/}
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
    root to: 'dashboards#index', as: :application

    # Devise
    as :user do
      get 'edit' => 'devise/registrations#edit', as: :edit_user_registration
    end

    resources :company, only: [:show] do
      resources :client do
        resources :offer
      end
    end
  end
end
