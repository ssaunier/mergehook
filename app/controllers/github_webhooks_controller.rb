class GithubWebhooksController < ActionController::Base
  include GithubWebhook::Processor

  MERGE_MESSAGE_PATTERN = /Merge pull request #(\d+) from [^\/]+\/(.*)/

  def push(payload)
    commit = Commit.new(payload)
    if commit.merge_to_master?
      tracker_project = Tracker::Project.new(@project.user.pivotal_tracker_api_token, @project.tracker_project_id)
      story = tracker_project.story(commit.story_id)
      story.finish
      story.add_label "pull-request"
    end
  end

  private

  def webhook_secret(payload)
    repo = "#{payload[:repository][:owner][:name]}/#{payload[:repository][:name]}"
    @project = Project.find_by_repo(repo)
    raise ActiveRecord::RecordNotFound.new("No project named #{repo} found") unless @project
    @project.github_webhook_secret
  end
end