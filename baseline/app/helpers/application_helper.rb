# frozen_string_literal: true

module ApplicationHelper
  def application_title
    ENV['APPLICATION_TITLE']
  end
end
