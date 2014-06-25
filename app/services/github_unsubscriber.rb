require "octokit"

class GithubUnsubscriber
  include Hook

  def initialize(project)
    @project = project
  end

  def run(user)
    client = Octokit::Client.new access_token: user.github_token
    client.unsubscribe pull_request_url(@project), callback_url
  end
end