class PullRequest < ActiveRecord::Base
  belongs_to :project

  def url
    "https://github.com/#{project.repo}/pull/#{number}"
  end
end
