class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  helper_method :current_user, :logged_in?

  ERRORS = {
    'ActiveRecord::RecordNotFound' => 'Errors::NotFound',
    'Errors::NotFound' => 'Errors::NotFound',
    'Errors::Unauthorized' => 'Errors::Unauthorized'
  }

  rescue_from StandardError, with: ->(error) { handle_error(error) }

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def handle_error(error)
    mapped = map_error(error)
    # notify about unexpected_error unless mapped
    mapped ||= Errors::StandardError.new
    render_error(mapped)
  end

  def map_error(error)
    error_klass = error.class.name
    return error if ERRORS.values.include?(error_klass)

    ERRORS[error_klass]&.constantize&.new
  end

  def render_error(error)
    render json: error.to_json, status: error.status
  end
end
