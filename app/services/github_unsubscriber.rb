require "octokit"

class GithubUnsubscriber
  include Hook

  def initialize(project)
    @project = project
  end

  def run(user)
    client = Octokit::Client.new access_token: user.github_token
    # client.unsubscribe push_url(@project), callback_url
    client.remove_hook @project.repo, @project.github_hook_id
  end
end