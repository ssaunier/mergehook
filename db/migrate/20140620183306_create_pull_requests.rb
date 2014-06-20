class CreatePullRequests < ActiveRecord::Migration
  def change
    create_table :pull_requests do |t|
      t.integer :number
      t.string :branch
      t.string :author
      t.string :title
      t.text :body
      t.string :story_id
      t.references :project, index: true

      t.timestamps
    end
  end
end
