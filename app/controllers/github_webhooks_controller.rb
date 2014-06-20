class GithubWebhooksController < ActionController::Base
  include GithubWebhook::Processor

  MERGE_MESSAGE_PATTERN = /Merge pull request #(\d+) from [^\/]+\/(.*)/

  def push(payload)
    commit = Commit.new(payload)
    if commit.merge_to_master?
      story = tracker_project.story(commit.story_id)
      story.finish
      story.add_label "pull-request"
    end
  end

  def pull_request(payload)
    case payload[:action] do
    when "opened"
      pull_request = PullRequestCreator.new(payload, @project).run
      if pull_request
        story = tracker_project(pull_request.story_id)
        # TODO: add comment to story
      end
    when "closed", "synchronize", "reopened"
      # Nothing yet
    end
  end

  private

  def webhook_secret(payload)
    repo = payload[:pull_request].nil? ? push_payload_repo : pull_request_payload_repo
    @project = Project.find_by_repo(repo)
    raise ActiveRecord::RecordNotFound.new("No project named #{repo} found") unless @project
    @project.github_webhook_secret
  end

  def push_payload_repo
    "#{payload[:repository][:owner][:name]}/#{payload[:repository][:name]}"
  end

  def pull_request_payload_repo
    "#{@payload[:pull_request][:base][:repo][:owner][:name]}/#{@payload[:pull_request][:base][:repo][:name]}"
  end

  def tracker_project
    @tracker_project ||= Tracker::Project.new(@project.user.pivotal_tracker_api_token, @project.tracker_project_id)
  end
end