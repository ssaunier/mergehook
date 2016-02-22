class PullRequestCreator < PullRequestActionBase
  def run
    return if story_id.blank?

    if pull_request
      story.add_label LABEL
      story.add_note "#{pull_request_markdown} has been opened."
      update_pull_request_description
    end
  end

  def update_pull_request_description
    client.update_pull_request @project.repo, pull_request.number, nil, pull_request.story_id
  end

end