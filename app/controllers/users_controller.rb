class UsersController < ApplicationController
  before_action :authenticate, except: :sign_in

  def show
  end

  def sign_in
    if signed_in?
      redirect_to(session.delete(:return_to) || root_path)
    else
      session[:return_to] = request.referrer
      authenticate
    end
  end

  def sign_out
    # Required by rack-cas
  end

  def update
    if current_user.update(user_params)
      redirect_to(root_path, notice: t(:settings_updated_successful))
    else
      render action: 'show'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :phone)
  end
end
