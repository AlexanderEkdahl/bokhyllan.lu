module NavigationHelper
  HIPCHAT = "https://www.hipchat.com/grR40Vhv6"

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
    link_to(current_user.login, user_path) if signed_in? and not controller?('users')
  end

  def about
    link_to(t(:about), about_path)
  end

  def support
    link_to(t(:support_feedback), HIPCHAT)
  end

  def edit
    item = @item || (@order ? @order.item : nil)

    if item && !current_page?(new_item_path) && !current_page?(edit_item_path(item))
      link_to(t(:edit_item), edit_item_path(item))
    end
  end

  def controller?(*controllers)
    controllers.include?(params[:controller])
  end
end
