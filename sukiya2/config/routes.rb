Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get "/" => "home#top"
  get "/home/about" => "home#about"

  get "/signup" => "users#new"
  get "/login" => "users#login_form"
  get "/users/index" => "users#index"
  #ユーザページ
  get "/users/:id" => "users#show"
  get "/users/:id/change_pwd" => "users#change_pwd_form"
  get "/users/:id/edit" => "users#edit"
  get "/users/:id/destroy" => "users#destroy_form"
  get "/users/:id/:date/shift" => "users#shift_form"
  post "/login" => "users#login"
  post "/logout" => "users#logout"
  post "/users/create" => "users#create"
  post "/excel_upload" => "users#excel"
  post "/form" => "users#form_create"
  post "/form_delete/:date" => "users#form_delete"
  post "/users/:id/change_pwd" => "users#change_pwd"
  post "/users/:id/update" => "users#update"
  post "/users/:id/destroy" => "users#destroy"
  post "/users/:id/:date/shift" => "users#shift"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
