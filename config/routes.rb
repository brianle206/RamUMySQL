Rails.application.routes.draw do
  root 'articles#landing'

  devise_for :users, controllers: { registrations: "registrations" }
  resources :articles, :admins, :questions, :courses, :badges, :assertions, :quiz #, :data
  resources :dashboard

  resources :courses do
    resources :learns, controller: 'learns' do
      resources :lectures, controller: 'lectures'
     
    end
    #resource :exam, controller: 'exams'
  end

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

  #Learn Routes and Lectures
  get '/learn/:id/add_lecture' => 'learns#add_lecture'
  # get '/learn/:id/lecture/:id' => 'learn#lecture_show'
  get '/course/:course_id/learn/:id/lecture/:lid/edit' => 'learns#lecture_edit' , as: :edit_lecture
  post '/course/:course_id/learn/:id/lecture/:lid/edit' => 'learns#lecture_update', as: :update_lecture
  post '/learn/:id/create_lecture' => 'learns#create_lecture'
  # delete '/learn/:id/lecture/:id' => 'learn#lecture_destroy'

  # Enrollment Routes
  # !!!!!!! These two are probably post & patch
  get 'enrollment/add'
  get 'enrollment/update'
  get '/enroll/:course_id' => 'enrollment#add'

  #Quiz Routes
  # get '/learn/:id/quiz/new' => 'quiz#new'
  get '/learn/:id/quiz/:id' => 'quiz#show', as: :take_quiz
  # post '/learn/:id/quiz/create' => 'quiz#create'
  get '/quizzes' => 'quiz#index'
  post '/learn/:id/quiz/:user_id' => 'quiz#create_user_answer', as: :user_quiz_answer
end
