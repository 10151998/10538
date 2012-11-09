Tag::Application.routes.draw do
  get "welcome/home" 
  get "/about" => "welcome#about"
  get "/team" => "welcome#team"
  get "/press" => "welcome#press"
  get "/investor" => "welcome#investor"

  # images
  resources :images

  # mentor_messages
  match "/mentor_messages/home" => "mentor_messages#home"
  match "/mentor_messages/inbox_list" => "mentor_messages#inbox_list"
  match "/mentor_messages/sentbox_list" => "mentor_messages#sentbox_list"
  resources :mentor_messages

  # videos
  match "/videos/user_video_list" => "videos#user_video_list"
  resources :videos

  # upload csv file
  match "/imports/proc/:id" => "imports#proc_csv"
  match "/imports/readme" => "imports#readme"
  resources :imports
  #map.import_proc '/import/proc/:id', :controller => "imports", :action => "proc_csv"

  # devise gem
  devise_for :users
  devise_for :admins
  devise_for :teachers
  devise_for :trainers

  resources :levels
    
  # fun_locations
  match "/fun_locations/index_admin" => "fun_locations#index_admin" 
  resources :fun_locations

  # team_challenges
  match "/team_challenges/team_challenge_list" => "team_challenges#team_challenge_list"  
  resources :team_challenges

  # challenge_messages
  match "/challenge_messages/home" => "challenge_messages#home" 
  match "/challenge_messages/new_invite" => "challenge_messages#new_invite" 
  match "/challenge_messages/new_reply" => "challenge_messages#new_reply" 
  match "/challenge_messages/inbox_list" => "challenge_messages#inbox_list" 
  match "/challenge_messages/sentbox_list" => "challenge_messages#sentbox_list" 
  resources :challenge_messages

  # user_points
  match "/user_points/point_list" => "user_points#point_list" 
  resources :user_points

  # team_points
  match "/team_points/point_list" => "team_points#point_list" 
  resources :team_points

  resources :user_game_preferences

  # games
  resources :games

  # user_funs
  match "/user_funs/attend" => "user_funs#attend" 
  resources :user_funs

  # funs
  match "/funs/fun_list" => "funs#fun_list" 
  match "/funs/my_fun_list" => "funs#my_fun_list" 
  match "/funs/fun_information" => "funs#fun_information" 
  match "/funs/search_fun" => "funs#search_fun"
  resources :funs

  resources :music_likes

  # musics
  match "/musics/home" => "musics#home"
  match "/musics/music_list" => "musics#music_list"
  resources :musics

  # sport_levels
  match "/sport_levels/sport_level_list" => "sport_levels#sport_level_list"
  match "/sport_levels/home" => "sport_levels#home"
  match "/sport_levels/guidence" => "sport_levels#guidence"
  match "/sport_levels/video" => "sport_levels#video"
  resources :sport_levels

  resources :scaffolds

  # admin
  match "/admin/home" => "admin#home"

  # user_sport_preferences
  resources :user_sport_preferences

  resources :pe_classmembers

  # pe_classes
  match "/pe_classes/home" => "pe_classes#home"
  match "/pe_classes/news_list" => "pe_classes#news_list"
  resources :pe_classes

  resources :schools

  resources :teammembers

  # team
  match "/teams/home" => "teams#home"
  match "/teams/team_information" => "teams#team_information"
  match "/teams/teamowner_information" => "teams#teamowner_information"
  match "/teams/team_information_list" => "teams#team_information_list"
  match "/teams/point_list" => "teams#point_list"
  match "/teams/levelup" => "teams#levelup"

  match "/teams/render_search_team" => "teams#render_search_team"
  match "/teams/search_team" => "teams#search_team" 
  resources :teams

  # sports
  resources :sports

  # trainers
  match "/trainers/trainer_list" => "trainers#trainer_list"  
  match "/trainers/home" => "trainers#home"  
  resources :trainers 

  # teachers
  match "/teachers/home" => "teachers#home" 
  match "/teachers/class_list" => "teachers#class_list" 
  match "/teachers/student_list" => "teachers#student_list" 
  match "/teachers/student_information" => "teachers#student_information" 
  match "/teachers/event_list" => "teachers#event_list" 
  resources :teachers

  # sessions
  #match "/sessions/user" => "sessions#user"
  #resources :sessions

  # user
  match "/users/home" => "users#home"

  match "/users/render_set_account" => "users#render_set_account"
  match "/users/set_account" => "users#set_account"

  match "/users/profile" => "users#profile"
  match "/users/render_update_password" => "users#render_update_password"
  match "/users/update_password" => "users#update_password"
  match "/users/render_update_username" => "users#render_update_username"
  match "/users/update_username" => "users#update_username"
  match "/users/render_update_email" => "users#render_update_email"
  match "/users/update_email" => "users#update_email"
  match "/users/render_update_avatar" => "users#render_update_avatar"
  match "/users/update_avatar" => "users#update_avatar"
  match "/users/upload" => "users#upload"
  resources :users

  match "/upload/upload" => "upload#upload"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # add for devise gem, 2012.7.25 Yueying
  # root :to => 'welcome#index'
  root :to => "welcome#home"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
