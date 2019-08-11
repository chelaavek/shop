class ApplicationController < ActionController::Base
  def after_sign_in_path_for(admin_users)
    store_index_path
  end

  def after_sign_out_path_for(admin_users)
    store_index_path
  end

  def authenticate_admin_user!
    raise SecurityError unless current_admin_user.role=='admin'
  end

  rescue_from SecurityError do |exception|
    redirect_to store_url
  end

end
