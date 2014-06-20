class Project < ActiveRecord::Base
  belongs_to :user

  before_create :generate_github_webhook_secret

  validates_presence_of :repo, :tracker_project_id

  private

  def generate_github_webhook_secret
    self.github_webhook_secret = (0...40).map { (33 + rand(93)).chr }.join
  end
end
