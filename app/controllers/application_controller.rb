class ApplicationController < ActionController::Base
  include ExceptionNotifiable
  local_addresses.clear
  protect_from_forgery
  rescue_from ActionController::InvalidAuthenticityToken, :with => :invalid_session
  filter_parameter_logging :pass, :key, :token

  around_filter :catch_errors
  before_filter :set_locale

  helper :all
  helper_method :current_admin, :mega_admin?, :demo?
  layout 'application'

  class <<self
    def exceptions_to_treat_as_404
      [ ActiveRecord::RecordNotFound,
        ActionController::UnknownController,
        ActionController::UnknownAction,
        ActionController::MethodNotAllowed,
        ActionController::RoutingError]
    end
  end

  protected

  def demo?
    false
  end

  def admin?
    true
  end

  def mega_admin?
    true
  end

  def demo_die
    demo? && flash[:error] = t('common.flash.demo') and redirect_to_back
  end

  def catch_errors
    yield
  rescue Exception => e
    logger.info "#{e.message} #{e.backtrace * "\n"}"
    flash[:error] = "#{t('common.flash.error')}: #{e.message}"
    ActiveRecord::Base.remove_connection
    ActiveRecord::Base.establish_connection
    redirect_to root_path unless params[:controller] == 'profile'
  end

  def invalid_session
    logger.info 'invalid token'
    redirect_to root_url(:return_to => request.request_uri)
  end

  def set_locale
    I18n.locale = 'en'
  end

  def redirect_to_back(default=:root_path)
    path=params[:return_to] || request.referer
    if !path || (path.at(0)!='/' && !path=~/\Ahttps?:\/\/#{request.host}\//)
      path=self.send(default) if default.kind_of? Symbol
      path=default if default.kind_of? String
    end
    redirect_to path
  end
end
