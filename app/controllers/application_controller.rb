class ApplicationController < ActionController::Base
  protect_from_forgery
  unless ActionController::Base.consider_all_requests_local
    rescue_from Exception, :with => :render_404
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    rescue_from ActionController::RoutingError, :with => :render_404
    rescue_from ActionController::UnknownController, :with => :render_404
    rescue_from ActionController::UnknownAction, :with => :render_404
  end
	  
  def render_404
    log_error(exception)
    render :template => "/public/404.html", :status => 404
  end  
 end 

 




