class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :authorize

  def authorize
    render json: { error: "Not Authorized" }, status: 401 unless session.include? :user_id
  end

end
