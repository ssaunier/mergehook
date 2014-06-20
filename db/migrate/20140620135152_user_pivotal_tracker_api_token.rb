class UserPivotalTrackerApiToken < ActiveRecord::Migration
  def change
    add_column :users, :pivotal_tracker_api_token, :string
  end
end
