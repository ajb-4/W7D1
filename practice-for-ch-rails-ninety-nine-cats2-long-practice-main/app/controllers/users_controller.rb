class UsersController < ApplicationController

    before_action :require_logged_out

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to user_url(@user)           
            login!(@user)
        else
            render :new
        end
    end

end
