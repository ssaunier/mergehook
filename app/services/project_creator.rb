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
        client.hooks(project.repo)
        # client.subscribe push_url(project), callback_url, project.github_webhook_secret
        hook = client.create_hook(project.repo,
          'web',
          {
            url: callback_url,
            content_type: :json,
            secret: project.github_webhook_secret
          },
          {
            events: [ :push ],
            active: true
          })
        project.github_hook_id = hook["id"]
        project.save
      rescue Octokit::UnprocessableEntity, Octokit::NotFound => e
        project.errors.add :repo, "Could not add github webhook on repo: #{e}"
      end
    end
    project
  end
end