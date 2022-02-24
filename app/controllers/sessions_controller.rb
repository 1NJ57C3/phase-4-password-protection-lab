class SessionsController < ApplicationController
    skip_before_action :authorize, only: [:create]

    def create
        u = User.find_by(username: params[:username])
        if u&.authenticate(params[:password])
            session[:user_id] = u.id
            render json: u, status: 201
        else
            render json: { error: "Invalid username or password" }, status: 401
        end
    end

    def destroy
        session.delete :user_id
        head :no_content
        # render json: {}, status: :no_content
    end
end