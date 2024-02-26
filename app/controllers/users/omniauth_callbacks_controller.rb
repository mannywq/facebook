class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication

    else

      session['devise.facebook_data'] = request.env['omniauth.auth'].except(:extra)

      redirect_to new_user_registration_path

    end
  end

  def google_oauth2
    user = User.from_google(request.env['omniauth.auth'])

    if user.persisted?
      # sign_out_all_scopes
      puts 'User found'
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect user, event: :authentication

    else
      flash[:alert] =
        I18n.t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{user.email} is not authorized."
      redirect_to new_user_session_path
    end
  end

  def failure
    redirect_to root_path
  end
end
