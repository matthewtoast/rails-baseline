# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  rescue_from RailsParam::Param::InvalidParameterError, with: :render_errors
  def render_errors(exception)
    render json: { errors: [exception] }, status: 400
  end

  # GET /
  def index
    if user_signed_in?
      redirect_to '/home'
    end
  end

  # GET /logout
  def logout
    reset_session
    redirect_to '/'
  end

  # GET /home
  def home; end
end
