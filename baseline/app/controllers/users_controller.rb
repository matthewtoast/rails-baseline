# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def account
    respond_to do |format|
      format.html
      format.json do
        if current_user.present?
          render json: {
            user: current_user.as_json,
          }
        else
          render json: {
            user: nil,
          }
        end
      end
    end
  end
end
