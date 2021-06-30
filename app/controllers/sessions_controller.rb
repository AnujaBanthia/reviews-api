class SessionsController < ApplicationController
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        render json: "Login successfully"
        else
            render json: "Invalid email or password"
        end
    end

    def destroy
        session[:user_id] = nil
        render json: "Logged out"
    end
end