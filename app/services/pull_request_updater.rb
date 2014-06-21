class PullRequestUpdater < PullRequestActionBase
  def run
    return unless pull_request

    story.add_note "#{pull_request_markdown} has been updated, you may have a look at it again."
  end
end