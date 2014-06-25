class PullRequest < ActiveRecord::Base
  belongs_to :project

  validates_uniqueness_of :number, scope: :project_id

  def url
    "https://github.com/#{project.repo}/pull/#{number}"
  end
end
