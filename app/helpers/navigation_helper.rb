module NavigationHelper
  def nav(*links)
    links.compact.join(' &middot; ').html_safe
  end

  def home
    link_to(t(:home).html_safe, root_path)# unless ['items', 'orders'].include?(params[:controller])
  end

  #TODO: should not be visibile if on /user after a failed login, should be not signed in and controller[:user]
  def sign_in
    link_to(t(:sign_in), sign_in_user_path) unless signed_in? or current_page?(sign_in_user_path)
  end

  def sign_out
    link_to(t(:sign_out), sign_out_user_path) if signed_in?
  end

  def user
    link_to(current_user.email, user_path) if signed_in? and not current_page?(user_path)
  end
end
