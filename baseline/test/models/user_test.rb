require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user' do
    u1 = User.create!(
      email: 'test@example.com',
      role_id: Role.where(name: 'user').first_or_create!.id,
    )
    assert_equal(u1.email, 'test@example.com')
  end
end
