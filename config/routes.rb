ActionController::Routing::Routes.draw do |map|
  
  map.resource  :session
    
  map.connect 'login', :controller => 'sessions', :action => 'new'
  
  map.resources :topics do |topics|
     topics.resources :questions, :collection => { :answers => :post } 
     topics.resources :topics               
  end
   
  map.resources :users
   
  map.assign_role 'assign_role', :controller => 'users', :action => 'assign_role'
   
  #map.root :controller => "topics"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
