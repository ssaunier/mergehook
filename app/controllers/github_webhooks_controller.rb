class GithubWebhooksController < ActionController::Base
  include GithubWebhook::Processor

  # def push(payload)
  #   commit = Commit.new(payload)
  #   if commit.merge_to_master?
  #     story = tracker_project.story(commit.story_id)
  #     story.finish
  #     story.remove_label "pull-request"
  #   end
  # end

  def pull_request(payload)
    case payload[:action]
    when "opened"
      PullRequestCreator.new(payload, @project).run
    when "closed"
      PullRequestCloser.new(payload, @project).run
    when "synchronize"
      PullRequestUpdater.new(payload, @project).run
    when "reopened"
      PullRequestReopener.new(payload, @project).run
    end
  end

  def webhook_secret(payload)
    repo = pull_request_payload_repo(payload)
    @project = Project.find_by_repo(repo)
    raise ActiveRecord::RecordNotFound.new("No project named #{repo} found") unless @project
    @project.github_webhook_secret
  end

  private

  def pull_request_payload_repo(payload)
    return payload[:repository][:full_name] if params[:zen]
    "#{payload[:pull_request][:base][:repo][:owner][:login]}/#{payload[:pull_request][:base][:repo][:name]}"
  end

end