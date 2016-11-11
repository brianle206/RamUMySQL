Rails.application.routes.draw do
  get 'enrollment/add'

  get 'enrollment/update'

  devise_for :users, controllers: { registrations: "registrations" }
  resources :articles, :lectures, :admins, :dashboard, :learns, :questions, :quizzes, :data, :courses, :badges, :assertions

  #Progress Tracker
  get '/progress/add/:learn_id/:user_id/:lecture_id' => 'progress#add'

  #Admin Routes
  get '/destroy/:id' => 'admin#destroy'
  get '/make_admin/:id' => 'admin#make_admin'
  get '/unmake_admin/:id' => 'admin#unmake_admin'
  get '/admin/manage' => 'admin#manage'
  get '/dashboard/progress' => 'dashboard#progress'
  get '/admin/learn/manage' => 'admin#learn', as: :admin_learn
  
  #Article Routes
  root 'articles#landing'
  get '/search' => 'articles#search'
  get '/new' => 'articles#new'

  #Learn Routes and Lectures
  get '/learn/:id/add_lecture' => 'learn#add_lecture'
  get '/learn/:id/lecture/:lid' => 'learn#lecture_show'
  get '/learn/:id/lecture/:lid/edit' => 'learn#lecture_edit' 
  post '/learn/:id/create_lecture' => 'learn#create_lecture'
  delete '/learn/:id/lecture/:lid' => 'learn#lecture_destroy'
  get '/enroll/:course_id' => 'enrollment#add'

  #Quiz Routes
  get '/learn/:id/quiz/new' => 'quiz#new'
  get '/learn/:id/quiz/:id' => 'quiz#show', as: :take_quiz
  post '/learn/:id/quiz/create' => 'quiz#create'
  post '/learn/:id/quiz/:user_id' => 'quiz#create_user_answer', as: :user_quiz_answer
end
