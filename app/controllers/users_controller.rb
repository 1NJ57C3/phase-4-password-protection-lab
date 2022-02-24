class UsersController < ApplicationController
    skip_before_action :authorize, only: [:create]

    def create
        u = User.create(u_params)
        if u.valid?
            session[:user_id] = u.id
            render json: u, status: 201
        else
            render json: { errors: u.errors.full_messages }, status: 422
        end
    end

    def show
        render json: User.find_by(id: session[:user_id])
    end

    private
    
    def u_params
        params.permit(:username, :password, :password_confirmation)
    end
end
