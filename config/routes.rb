Rails.application.routes.draw do
  root 'articles#landing'

  # BadgesEngine routes
  resources :badges, controller: 'badges_engine/badges'
  resources :assertions, controller: 'badges_engine/assertions' 
  get 'assertion/:id/:uid.json' => 'badges_engine/assertions#bake_callback', defaults: { format: 'json' }, as: :secret_assertion

  devise_for :users, controllers: { registrations: "registrations" }
  resources :articles, :admins, :questions, :courses, :quiz #, :data
  resources :exams, except: :show
  resources :dashboard

  resources :courses, shallow: true do
    resources :learns, shallow: true do
      resources :lectures, controller: 'lectures'
    end
    resource :exam, controller: 'exams', only: :show
  end

  # Submit Exam, assign badge
  post 'courses/:id/exam' => 'exams#create_user_answer', as: :user_exam_answer


  #Progress Tracker
  get '/progress/add/:learn_id/:user_id/:lecture_id' => 'progress#add'

  #Admin Routes
  get '/destroy/:id' => 'admins#destroy'
  get '/make_admin/:id' => 'admins#make_admin'
  get '/unmake_admin/:id' => 'admins#unmake_admin'
  get '/admin/manage' => 'admins#show'
  get '/dashboard/progress' => 'dashboard#progress'
  get '/admin/learn/manage' => 'admins#learn', as: :admin_learn
  get '/admin/manage_courses' => 'admins#manage_courses', as: :manage_courses
  
  #Article Routes
  get '/search' => 'articles#search'

  #Dashboard Routes
  get '/dashboard' => 'dashboard#show'

  # Enrollment Routes
  # !!!!!!! These two are probably post & patch
  get 'enrollment/add'
  get 'enrollment/update'
  get '/enroll/:course_id' => 'enrollment#add'

  #Quiz Routes
  get '/learn/:id/quiz/new' => 'quiz#new'
  get '/learn/:learn_id/quiz/:quiz_id' => 'quiz#show', as: :take_quiz
  post '/learn/:id/quiz/create' => 'quiz#create'
  get '/quizzes' => 'quiz#index'
  post '/learn/:id/quiz/:user_id' => 'quiz#create_user_answer', as: :user_quiz_answer
end
