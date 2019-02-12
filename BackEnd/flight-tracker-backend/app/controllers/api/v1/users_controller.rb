class Api::V1::UsersController < ApplicationController

    def new
      @user = User.new
    end

    def show
      @user = User.find(params[:id])
      render json: @user
    end

    private

    def user_params
      params.permit(:username)
    end

end
