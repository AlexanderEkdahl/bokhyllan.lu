module NavigationHelper
  def nav(*links)
    links.delete_if(&:nil?).join(' &middot; ').html_safe
  end

  def home
    link_to 'Home', root_path unless params[:controller] == 'items'
  end

  def sign_in
    link_to('Sign in', sign_in_user_path) unless signed_in? or current_page?(sign_in_user_path)
  end

  def sign_out
    link_to('Sign out', sign_out_user_path) if signed_in?
  end

  def settings
    link_to('Settings', edit_user_path) if signed_in? and not current_page?(edit_user_path)
  end
end
