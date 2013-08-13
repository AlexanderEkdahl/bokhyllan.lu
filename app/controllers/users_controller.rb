class UsersController < ApplicationController
  before_action :authenticate, only: [:show, :edit, :update]

  def sign_in
    @user = User.new
  end

  def create
    @user = User.find_or_create_by_login(params[:user][:login])

    if @user.new_record?
      @user.password = params[:user][:password]
      if @user.save
        session[:user_id] = @user.id
        UserMailer.verification_email(@user).deliver
        redirect_to(root_path, notice: t(:sign_in_success))
      else
        render 'sign_in'
      end
    else
      if @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to(root_path, notice: t(:sign_in_success))
      else
        @sign_in_unsuccessful = true
        flash.now[:alert] = t(:sign_in_unsuccessful)
        render 'sign_in'
      end
    end
  end

  def sign_out
    reset_session
    redirect_to(root_path, notice: t(:sign_out_success))
  end

  def show
  end

  def update
    if current_user.update(user_params)
      redirect_to(root_path, notice: t(:settings_updated_successful))
    else
      render action: 'show'
    end
  end

  def verify
    user = User.find_by_verification_key(params[:key])

    if user
      user.verify!
      session[:user_id] = user.id
      redirect_to(root_path, success: t(:user_verified, email: user.email))
    else
      head(:forbidden)
    end
  end

  def reset
    @user = User.find_by(login: params[:login])

    if @user
      UserMailer.reset_email(@user).deliver
      flash.now[:success] = t(:reset_email_sent, email: @user.email)
      render 'sign_in'
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :current_password, :name, :phone)
    end
end
