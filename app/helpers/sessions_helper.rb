module SessionsHelper
  def current_user
    current_session.try(:user)
  end

  def current_session
    Session.find_by_session_token(session[:session_token])
  end

  def login_user!(user)
    new_session = user.sessions.create!(
      env: request.env["HTTP_USER_AGENT"],
      location: request.location.city
    )
    flash[:notices] = "Welcome #{user.user_name}!"
    session[:session_token] = new_session.session_token
  end
end
