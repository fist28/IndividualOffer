# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                  Controller#Action
#          new_user_session GET    /sign_in(.:format)                                                           devise/sessions#new
#              user_session POST   /sign_in(.:format)                                                           devise/sessions#create
#      destroy_user_session DELETE /sign_out(.:format)                                                          devise/sessions#destroy
#             user_password POST   /password(.:format)                                                          devise/passwords#create
#         new_user_password GET    /password/new(.:format)                                                      devise/passwords#new
#        edit_user_password GET    /password/edit(.:format)                                                     devise/passwords#edit
#                           PATCH  /password(.:format)                                                          devise/passwords#update
#                           PUT    /password(.:format)                                                          devise/passwords#update
#     new_user_registration GET    /signup(.:format)                                                            devise/registrations#new
#         user_registration POST   /signup(.:format)                                                            devise/registrations#create
#                      root GET    /                                                                            devise/sessions#new
#               application GET    /:user_id(.:format)                                                          dashboards#index {:user_id=>/([0-9]+)/}
#    edit_user_registration GET    /:user_id/edit(.:format)                                                     devise/registrations#edit {:user_id=>/([0-9]+)/}
#         product_calculate POST   /:user_id/products/:product_id/calculate(.:format)                           products#async_calculate_change_price {:user_id=>/([0-9]+)/}
#                  products GET    /:user_id/products(.:format)                                                 products#index {:user_id=>/([0-9]+)/}
#                           POST   /:user_id/products(.:format)                                                 products#create {:user_id=>/([0-9]+)/}
#               new_product GET    /:user_id/products/new(.:format)                                             products#new {:user_id=>/([0-9]+)/}
#              edit_product GET    /:user_id/products/:id/edit(.:format)                                        products#edit {:user_id=>/([0-9]+)/}
#                   product GET    /:user_id/products/:id(.:format)                                             products#show {:user_id=>/([0-9]+)/}
#                           PATCH  /:user_id/products/:id(.:format)                                             products#update {:user_id=>/([0-9]+)/}
#                           PUT    /:user_id/products/:id(.:format)                                             products#update {:user_id=>/([0-9]+)/}
#                           DELETE /:user_id/products/:id(.:format)                                             products#destroy {:user_id=>/([0-9]+)/}
#                categories GET    /:user_id/categories(.:format)                                               categories#index {:user_id=>/([0-9]+)/}
#                           POST   /:user_id/categories(.:format)                                               categories#create {:user_id=>/([0-9]+)/}
#                  category GET    /:user_id/categories/:id(.:format)                                           categories#show {:user_id=>/([0-9]+)/}
#                           PATCH  /:user_id/categories/:id(.:format)                                           categories#update {:user_id=>/([0-9]+)/}
#                           PUT    /:user_id/categories/:id(.:format)                                           categories#update {:user_id=>/([0-9]+)/}
#                           DELETE /:user_id/categories/:id(.:format)                                           categories#destroy {:user_id=>/([0-9]+)/}
#     company_client_offers GET    /:user_id/companies/:company_id/clients/:client_id/offers(.:format)          clients/offers#index {:user_id=>/([0-9]+)/}
#                           POST   /:user_id/companies/:company_id/clients/:client_id/offers(.:format)          clients/offers#create {:user_id=>/([0-9]+)/}
#  new_company_client_offer GET    /:user_id/companies/:company_id/clients/:client_id/offers/new(.:format)      clients/offers#new {:user_id=>/([0-9]+)/}
# edit_company_client_offer GET    /:user_id/companies/:company_id/clients/:client_id/offers/:id/edit(.:format) clients/offers#edit {:user_id=>/([0-9]+)/}
#      company_client_offer GET    /:user_id/companies/:company_id/clients/:client_id/offers/:id(.:format)      clients/offers#show {:user_id=>/([0-9]+)/}
#                           PATCH  /:user_id/companies/:company_id/clients/:client_id/offers/:id(.:format)      clients/offers#update {:user_id=>/([0-9]+)/}
#                           PUT    /:user_id/companies/:company_id/clients/:client_id/offers/:id(.:format)      clients/offers#update {:user_id=>/([0-9]+)/}
#                           DELETE /:user_id/companies/:company_id/clients/:client_id/offers/:id(.:format)      clients/offers#destroy {:user_id=>/([0-9]+)/}
#           company_clients GET    /:user_id/companies/:company_id/clients(.:format)                            clients#index {:user_id=>/([0-9]+)/}
#                           POST   /:user_id/companies/:company_id/clients(.:format)                            clients#create {:user_id=>/([0-9]+)/}
#        new_company_client GET    /:user_id/companies/:company_id/clients/new(.:format)                        clients#new {:user_id=>/([0-9]+)/}
#       edit_company_client GET    /:user_id/companies/:company_id/clients/:id/edit(.:format)                   clients#edit {:user_id=>/([0-9]+)/}
#            company_client GET    /:user_id/companies/:company_id/clients/:id(.:format)                        clients#show {:user_id=>/([0-9]+)/}
#                           PATCH  /:user_id/companies/:company_id/clients/:id(.:format)                        clients#update {:user_id=>/([0-9]+)/}
#                           PUT    /:user_id/companies/:company_id/clients/:id(.:format)                        clients#update {:user_id=>/([0-9]+)/}
#                           DELETE /:user_id/companies/:company_id/clients/:id(.:format)                        clients#destroy {:user_id=>/([0-9]+)/}
#                   company GET    /:user_id/companies/:id(.:format)                                            companies#show {:user_id=>/([0-9]+)/}
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

    resources :products do
      post 'calculate' => 'products#async_calculate_change_price'
    end
    resources :categories, except: [:edit]

    resources :companies, only: [:show] do
      resources :clients do
        resources :offers, controller: 'clients/offers'
      end
    end
  end
end
