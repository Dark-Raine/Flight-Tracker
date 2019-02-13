class Api::V1::UsersController < ApplicationController

    def create
      # byebug
      @user = User.create(username: params[:username])
      render json: @user
    end

    def show
      @user = User.find(params[:id])
      render json: @user
    end

    private

    def user_params
      params.permit(:user).require(:username)
    end

end
