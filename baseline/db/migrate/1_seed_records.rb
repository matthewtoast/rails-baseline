class SeedRecords < ActiveRecord::Migration[6.0]
  def change
    Role.create!(name: 'user')
    Role.create!(name: 'admin')
    # User.create!([])
  end
end
