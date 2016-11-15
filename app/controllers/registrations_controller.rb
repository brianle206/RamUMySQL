class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    '/courses' # Redirect after devise sign-up
  end
end