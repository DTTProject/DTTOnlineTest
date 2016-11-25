class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  respond_to :html, :json
  def after_sign_in_path_for resource
    if current_user.admin?
      admin_users_path
    else
      root_path
    end
  end
  # after_action :create_log, only: :create
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end
  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource
    if resource.valid_password?(params[:user][:password])
      sign_in :user, resource
      create_log
      return render json: current_user
    end

    invalid_login_attempt
   end
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def invalid_login_attempt
    set_flash_message(:error, :invalid)
    render json: flash[:error], status: 401
  end

  def create_log
    # if params[:commit] == "Log in"
      content = "User #{current_user.email} #{t("devise.sessions.had_been_signed_in")}"
    # end
    CUSTOM_LOGGER.info content
  end
end
