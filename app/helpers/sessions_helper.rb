module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end