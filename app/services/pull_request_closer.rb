class PullRequestCloser < PullRequestActionBase
  def run
    return unless pull_request

    client = Octokit::Client.new access_token: @project.user.github_token
    if client.pull_merged?(@project.repo, pull_request.number)
      story.finish
      story.add_note "#{pull_request_markdown} has been **merged**, marking story as **finished**."
    else
      story.add_note "#{pull_request_markdown} has been closed (and **not** merged)."
    end
    story.remove_label LABEL
  end
end