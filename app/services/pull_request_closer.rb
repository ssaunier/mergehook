class PullRequestCloser < PullRequestActionBase
  def run
    return if story_id.blank? || pull_request.nil?

    if @payload[:pull_request][:merged]
      story.deliver
      # story.add_note "#{pull_request_markdown} has been **merged**, marking story as **delivered**."
    else
      story.add_note "#{pull_request_markdown} has been closed (and **not** merged)."
    end
    story.remove_label LABEL
  end
end