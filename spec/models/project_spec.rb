require 'rails_helper'

RSpec.describe Project, :type => :model do
  it "should generate a github_webhook_secret on creation" do
    project = Project.new repo: "ssaunier/test", tracker_project_id: "123"
    project.save!
    expect(project.reload.github_webhook_secret.length).to eq 40
  end

  it "should downcase repo before validation" do
    project = Project.new repo: "SsauNier/TesT", tracker_project_id: "123"
    project.valid?
    expect(project.repo).to eq "ssaunier/test"
  end
end
