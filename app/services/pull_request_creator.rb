class PullRequestCreator
  def initialize(pull_request_event_payload, project)
    @payload = pull_request_event_payload
    @project = project
  end

  def run
    @project.pull_requests.create!(pull_request_params)
  end

  private

  def pull_request_params
    {
      number: @payload[:number],
      branch: @payload[:pull_request][:head][:ref],
      author: @payload[:pull_request][:head][:user][:login],
      title:  @payload[:pull_request][:title],
      body:   @payload[:pull_request][:body],
      story_id: @payload[:pull_request][:head][:ref][/#?(\d{6,10})/, 1]
    }
  end
end