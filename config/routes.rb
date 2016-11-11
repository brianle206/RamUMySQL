Rails.application.routes.draw do
  root 'articles#landing'

  devise_for :users, controllers: { registrations: "registrations" }
  resources :articles, :admins, :questions, :courses, :badges, :assertions #, :data
  resources :dashboard

  resources :courses do
    resources :learns, controller: 'learns' do
      resources :lectures, controller: 'lectures'
      resource :quiz, controller: 'quiz'
    end
    #resource :exam, controller: 'exams'
  end

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
  get '/search' => 'articles#search'

  #Dashboard Routes
  get '/dashboard' => 'dashboard#show'

  #Learn Routes and Lectures
  get '/learn/:id/add_lecture' => 'learn#add_lecture'
  # get '/learn/:id/lecture/:id' => 'learn#lecture_show'
  # get '/learn/:id/lecture/:id/edit' => 'learn#lecture_edit' 
  post '/learn/:id/create_lecture' => 'learn#create_lecture'
  # delete '/learn/:id/lecture/:id' => 'learn#lecture_destroy'

  # Enrollment Routes
  # !!!!!!! These two are probably post & patch
  get 'enrollment/add'
  get 'enrollment/update'
  get '/enroll/:course_id' => 'enrollment#add'

  #Quiz Routes
  # get '/learn/:id/quiz/new' => 'quiz#new'
  # get '/learn/:id/quiz/:id' => 'quiz#show', as: :take_quiz
  # post '/learn/:id/quiz/create' => 'quiz#create'
  get '/quizzes' => 'quiz#index'
  post '/learn/:id/quiz/:user_id' => 'quiz#create_user_answer', as: :user_quiz_answer
end
