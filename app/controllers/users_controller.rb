class UsersController < ApplicationController
  before_action :authenticate, only: [:show, :edit, :update]

  def sign_in
    @user = User.new
  end

  def create
    @user = User.find_or_create_by(login: params[:user][:login])

    if @user.new_record?
      @user.password = params[:user][:password]
      if @user.save
        UserMailer.verification_email(@user).deliver
        session[:user_id] = @user.id
        redirect_to(root_path, notice: t(:sign_in_success))
      else
        render 'sign_in'
      end
    else
      if @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to(root_path, notice: t(:sign_in_success))
      else
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

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to(root_path, notice: t(:settings_updated_successful))
    else
      render action: 'edit'
    end
  end

  def verify
    user = User.find_by_verification_key(params[:key])
    head :forbidden and return unless user
    user.update_attribute(:verified, true)
    session[:user_id] = user.id
    redirect_to root_path, flash: { success: t(:user_verified, email: user.email)}
  end

  private
    def user_params
      params.require(:user).permit(User.properties_keys, :password, :current_password)
    end
end
