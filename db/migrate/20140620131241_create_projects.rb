class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :repo
      t.string :tracker_project_id
      t.string :github_webhook_secret

      t.timestamps
    end
  end
end
