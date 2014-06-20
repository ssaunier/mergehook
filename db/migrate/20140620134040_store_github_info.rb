class StoreGithubInfo < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :github_nickname, :string
    add_column :users, :gravatar_url, :string
    add_column :users, :name, :string
    add_column :users, :github_token, :string
  end
end
