Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth/v1/user'
end
