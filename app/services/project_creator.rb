require "octokit"

class ProjectCreator
  include Hook

  def initialize(params)
    @params = params
  end

  def run(user)
    project = user.projects.build @params
    if project.valid?
      client = Octokit::Client.new access_token: user.github_token
      begin
        if client.subscribe pull_request_url(project), callback_url, project.github_webhook_secret
          project.github_hook_added_at = DateTime.now
          project.save
        end
      rescue Octokit::UnprocessableEntity, Octokit::NotFound => e
        project.errors.add :repo, "Could not add github webhook on repo: #{e}"
      end
    end
    project
  end
end