class PullRequestReopener < PullRequestActionBase
  def run
    return if story_id.blank? || pull_request.nil?

    story.add_note "#{pull_request_markdown} has been reopened."
    story.add_label LABEL
  end
end