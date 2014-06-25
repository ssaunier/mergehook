class PullRequestCreator < PullRequestActionBase
  def run
    return if story_id.blank?

    if pull_request
      story.add_label LABEL
      story.add_note "#{pull_request_markdown} has been opened."
    end
  end
end