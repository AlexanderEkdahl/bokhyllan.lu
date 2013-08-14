module NavigationHelper
  def nav(*links)
    links.compact.join(' &middot; ').html_safe
  end

  def home
    link_to(t(:home), root_path) unless controller?('items', 'orders')
  end

  def sign_in
    link_to(t(:sign_in), sign_in_user_path) unless signed_in? or controller?('users')
  end

  def sign_out
    link_to(t(:sign_out), sign_out_user_path) if signed_in?
  end

  def user
    link_to(current_user.email, user_path) if signed_in? and not controller?('users')
  end

  private

    def controller?(*controllers)
      controllers.include?(params[:controller])
    end
end
