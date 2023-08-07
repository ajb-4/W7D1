class SessionsController < ApplicationController

    before_action :require_logged_out
    
    def new
        @user = User.new
        render: new
    end

    def create

        @user = User.find_by_credential(
            params[:user][:username]
            params[:user][:password]
        )
        if @user
            login!(@user)
            redirect_to user_url(@user.id)
        else
            @user = User.new(username: params[:user][:username])
            render :new
        end
    end


    def destroy
        if current_user
            reset_session_token!(current_user)
        end
        session[:session_token] = nil
    end

end
