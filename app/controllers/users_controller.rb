class UsersController < ApplicationController
  before_action :authenticate, only: [:show, :edit, :update]

  def sign_in
    @user = User.new
  end

  def create
    @user = User.authenticate(params[:user].symbolize_keys)
    if @user
      session[:user_id] = @user.id
      redirect_to(root_path, notice: t(:sign_in_success))
    else
      @user = User.new
      flash.now[:alert] = t(:sign_in_unsuccessful)
      render 'sign_in'
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
