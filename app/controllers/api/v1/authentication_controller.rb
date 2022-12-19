module Api
  module V1
    class AuthenticationController < ApplicationController
      class AuthenticateError < StandardError; end

      # Syntax: rescue_from `exception` with `method`
      rescue_from ActionController::ParameterMissing, with: :missing_parameter
      rescue_from AuthenticateError, with: :handle_unauthenticated_user

      # Using create to mimic user login
      def create
        if is_user_valid
          raise AuthenticateError unless user.authenticate(params.require(:password))
          render json: UserRepresenter.new(user).as_json, status: :created
        else
          render json: { error: 'No such user' }, status: :unauthorized
        end
      end

      private
      def is_user_valid
        # Syntax: @my_user || @my_user = {SOMETHING}
        @user ||= User.find_by(username: params.require(:username))
      end

      def missing_parameter(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end

      def handle_unauthenticated_user
        render json: { error: 'Incorrect password' }, status: :unauthorized
      end
    end
  end
end