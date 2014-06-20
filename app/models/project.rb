class Project < ActiveRecord::Base
  belongs_to :user
  has_many :pull_requests

  before_validation :ensure_github_webhook_secret

  validates_format_of :repo, with: /\A[^\/]+\/[^\/]+\Z/
  validates_presence_of :repo, :tracker_project_id
  validates_uniqueness_of :repo

  private

  def ensure_github_webhook_secret
    self.github_webhook_secret ||= (0...40).map { (33 + rand(93)).chr }.join
  end
end
