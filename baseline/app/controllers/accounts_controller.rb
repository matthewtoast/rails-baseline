# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :logout]

  def show
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

  def logout
    reset_session
    redirect_to '/'
  end
end
