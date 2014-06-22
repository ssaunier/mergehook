class UsersController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to projects_path, notice: "Pivotal Tracker API token has been saved"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:pivotal_tracker_api_token)
  end
end