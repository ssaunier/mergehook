class ProjectBelongsToUser < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.references :user, index: true
    end
  end
end
