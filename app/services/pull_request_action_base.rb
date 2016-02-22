require "octokit"

class PullRequestActionBase
  LABEL = "pull-request"

  def initialize(pull_request_event_payload, project)
    @payload = pull_request_event_payload
    @project = project
  end

  def story_id
    @payload[:pull_request][:head][:ref][/#?(\d{6,10})/, 1]
  end

  private

  def pull_request
    @pull_request ||= (
      @project.pull_requests.find_by_number(@payload[:number]) ||
        @project.pull_requests.create!(pull_request_params)
    )
  end

  def pull_request_params
    {
      number: @payload[:number],
      branch: @payload[:pull_request][:head][:ref],
      author: @payload[:pull_request][:head][:user][:login],
      title:  @payload[:pull_request][:title],
      body:   @payload[:pull_request][:body],
      story_id: story_id
    }
  end

  def story
    @story ||= Tracker::Project.from_project(@project).story(pull_request.story_id)
  end

  def client
    @client ||= Octokit::Client.new access_token: @project.user.github_token
  end

  def pull_request_markdown
    "Pull Request [##{pull_request.number}](#{pull_request.url})"
  end
end