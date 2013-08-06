class UsersController < ApplicationController
  before_action :authenticate, only: [:show, :edit, :update]

  def sign_in
    @user = User.new
  end

  def create
    @user = User.find_or_create_by(login: params[:user][:login].downcase)

    if @user.new_record?
      @user.password = params[:user][:password]
      if @user.save
        session[:user_id] = @user.id
        track("Signed in for the first time")
        UserMailer.verification_email(@user).deliver
        redirect_to(root_path, notice: t(:sign_in_success))
      else
        render 'sign_in'
      end
    else
      if @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        track("Signed in")
        redirect_to(root_path, notice: t(:sign_in_success))
      else
        flash.now[:alert] = t(:sign_in_unsuccessful)
        render 'sign_in'
      end
    end
  end

  def sign_out
    track("Signed out")
    reset_session
    redirect_to(root_path, notice: t(:sign_out_success))
  end

  def show
    # fresh_when(current_user)
  end

  def update
    if current_user.update(user_params)
      track("Updated the profile")
      redirect_to(root_path, notice: t(:settings_updated_successful))
    else
      render action: 'edit'
    end
  end

  def verify
    user = User.find_by_verification_key(params[:key])

    if user
      user.verify!
      session[:user_id] = user.id
      track("Verified the email")
      redirect_to(root_path, success: t(:user_verified, email: user.email))
    else
      head(:forbidden)
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :current_password, :name, :phone)
    end
end
