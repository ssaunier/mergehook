class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.find_for_github_oauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
    else
      # session["devise.github_data"] = request.env["omniauth.auth"]
      flash[:error] = "Please ask a Wagon administrator to remove your account first"
      redirect_to unauthenticated_root_path
    end
  end
end
