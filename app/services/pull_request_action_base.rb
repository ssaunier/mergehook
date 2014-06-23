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
    @pull_request ||= @project.pull_requests.find_by_number(@payload[:number])
  end

  def story
    @story ||= Tracker::Project.from_project(@project).story(pull_request.story_id)
  end

  def pull_request_markdown
    "Pull Request [##{pull_request.number}](#{pull_request.url})"
  end
end