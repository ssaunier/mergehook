class GithubWebhooksController < ActionController::Base
  include GithubWebhook::Processor

  def github_pull_request(payload)
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
    (params[:zen] ? payload[:repository][:full_name] : payload[:pull_request][:base][:repo][:full_name]).downcase
  end

end