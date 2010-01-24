ActionController::Routing::Routes.draw do |map|
  map.resources :sessions, :only => [:index, :show, :new, :create]

  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.login 'login', :controller => 'user_sessions', :action => 'new'

  map.resources :audience_levels, :only => [:index]
  map.resources :session_types, :only => [:index]
  map.resources :tags, :only => [:index]
  map.resources :tracks, :only => [:index]
  map.resources :user_sessions, :only => [:new, :create, :destroy]
  map.resources :users, :only => [:index, :new, :create, :show] do |user|
    user.my_sessions 'my_sessions', :controller => 'sessions', :action => 'index'
  end

  map.root :controller => 'user_sessions', :action => 'new'
end