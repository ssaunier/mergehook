class GithubHookAddedAt < ActiveRecord::Migration
  def change
    add_column :projects, :github_hook_added_at, :datetime
    remove_column :projects, :github_hook_id
  end
end
