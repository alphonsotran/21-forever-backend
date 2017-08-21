module Api
  class UsersController < ApplicationController

    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def show
    end


    def new
      @user = User.new
    end

    def edit
      if @user
        render json: @user, only: [:email, :name],  status: 200
      else
        render text: "Unidentified user", status: 422
      end
    end

    def create
      @user = User.new(user_params)
        if @user.save
          render text: @user.access_token, status: 201
        else
          render json: @user.errors, status: 422
        end
    end

    def update
      if @user.update_attributes(user_params)
        render text: "Account has been updated successfully", status: 200
      else
        render json: @user.errors, status: 422
      end
    end

    def destroy
      if @user.destroy
        render text: "Account has been deleted successfully", status: 200
      else
        render text: "Something went wrong", status: 422
      end
    end

    private

      def set_user
        @user = User.find_by(access_token: params[:access_token])
      end

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end

  end
end