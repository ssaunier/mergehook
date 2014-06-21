class PullRequestReopener < PullRequestActionBase
  def run
    return unless pull_request

    story.add_note "#{pull_request_markdown} has been reopened."
    story.add_label LABEL
  end
end