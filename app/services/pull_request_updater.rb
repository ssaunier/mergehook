class PullRequestUpdater < PullRequestActionBase
  def run
    return if story_id.blank? || pull_request.nil?

    # no need for this
    # story.add_note "#{pull_request_markdown} has been updated, you may have a look at it again."
  end
end