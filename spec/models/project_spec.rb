require 'rails_helper'

RSpec.describe Project, :type => :model do
  it "should generate a github_webhook_secret on creation" do
    project = Project.new repo: "ssaunier/test", tracker_project_id: "123"
    project.save!
    expect(project.reload.github_webhook_secret.length).to eq 40
  end
end
