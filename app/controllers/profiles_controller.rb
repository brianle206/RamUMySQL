class ProfilesController < ApplicationController
  def show
  end

  def create
    @profile = Profile.create(profile_params)
    if @profile.save
      redirect_to dashboard_index_path
    end
  end

  def edit
  end

  def update
    find_profile
    @profile.update(profile_params)
    redirect_to dashboard_index_path
  end

  def destroy
  end

  def index
    find_profile
  end

  def new
    @profile = Profile.new
  end

  private

  def profile_params
    params.require(:profile).permit(:firstName, :lastName, :address, :country, :state, :zipcode, :phoneNumber, :user_id, :avatar)
  end

  def find_profile
    @profile = Profile.find_by(user_id: current_user.id)
  end

end
