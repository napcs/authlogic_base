ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  map.resources :password_resets
  map.resource :user_session
  map.resources :users
  #map.resource :profile  
  map.resource :dashboard, :controller => "dashboard"
  
  
  map.register '/register/:activation_code', :controller => 'activations', :action => 'new'
  map.activate '/activate/:id', :controller => 'activations', :action => 'create'
  
  map.signup "/signup", :controller => "users", :action => "new"
  map.login "/login", :controller => "user_sessions", :action => "new"
  map.logout "/logout", :controller => "user_sessions", :action => "destroy"

  map.help "/help", :controller => "public_pages", :action => "help"
  map.how_this_works "/how_this_works", :controller => "public_pages", :action => "how_this_works"
  map.our_company "/our_company", :controller => "public_pages", :action => "our_company"
  map.contact_us "/contact_us", :controller => "public_pages", :action => "contact_us"
  map.bookmark "/bookmark", :controller => "public_pages", :action => "bookmark"
  map.tell_a_friend "/tell_a_friend", :controller => "public_pages", :action => "tell_a_friend"
  map.frequently_asked_questions "/frequently_asked_questions", :controller => "public_pages", :action => "frequently_asked_questions"
  map.technical_problems "/technical_problems", :controller => "public_pages", :action => "technical_problems"
  map.sitemap "/sitemap", :controller => "public_pages", :action => "sitemap"
  map.terms_of_use "/terms_of_use", :controller => "public_pages", :action => "terms_of_use"
  map.privacy "/privacy", :controller => "public_pages", :action => "privacy"
  map.bookmark "/bookmark", :controller => "public_pages", :action => "bookmark"

  map.root :controller =>"public_pages", :action => "index"

end
