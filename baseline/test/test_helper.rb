# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def json_response
    ActiveSupport::JSON.decode response.body
  end

  def user
    role = Role.where(name: 'user').first_or_create!
    User.where(email: 'test@example.com', role_id: role.id).first_or_create!
  end
end
