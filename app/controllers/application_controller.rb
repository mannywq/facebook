class ApplicationController < ActionController::Base
  layout :layout_by_resource

  def authenticate_user!
    if user_signed_in?

      super
    else
      redirect_to new_user_session_path
    end
  end

  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end
end
