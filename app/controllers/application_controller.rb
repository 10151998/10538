class ApplicationController < ActionController::Base
  protect_from_forgery

  # devise gem
  # redirect to a specific page on successful sign in
  # https://github.com/plataformatec/devise/wiki/How-to%3A-redirect-to-a-specific-page-on-successful-sign-in-out
  # 2012.7.26 Yueying
  def after_sign_in_path_for(resource)
    # user role
    if resource.instance_of?(User)
      if resource.active_code == 0
        '/users/render_set_account'
      elsif resource.active_code == 1
        '/teams/render_search_team'
      elsif resource.active_code == 2
        '/teams/home'
      else
        '/users/sign_in'
      end
    # admin role
    elsif resource.instance_of?(Admin)
      '/imports/new'
    # teacher role
    elsif resource.instance_of?(Teacher)
      '/teachers/home'
    # trainer role
    elsif resource.instance_of?(Trainer)
      '/trainers/home'
    end
  end

  # devise gem
  # redirect to a specific page on successful sign out
  # http://rubydoc.info/github/plataformatec/devise/master/Devise/Controllers/Helpers:after_sign_out_path_for
  # 2012.7.26 Yueying
  def after_sign_out_path_for(resource)
    # user role
    if resource.instance_of?(User)
      '/users/sign_in'
    # admin role
    elsif resource.instance_of?(Admin)
      '/admins/sign_in'
    # teacher role
    elsif resource.instance_of?(Teacher)
      '/admins/sign_in'
    # trainer role
    elsif resource.instance_of?(Trainer)
      '/admins/sign_in'
    end
  end

  # multi-roles use same controller
  def authenticate_user_or_trainer
    unless user_signed_in? or trainer_signed_in?
      if admin_signed_in?
        redirect_to '/imports/new'
      elsif teacher_signed_in?
        redirect_to  '/teachers/home'
      end
    end
  end

end
