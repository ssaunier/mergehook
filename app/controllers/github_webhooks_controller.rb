class GithubWebhooksController < ActionController::Base
  include GithubWebhook::Processor

  MERGE_MESSAGE_PATTERN = /Merge pull request #(\d+) from [^\/]+\/(.*)/

  def push(payload)
    commit = Commit.new(payload)
    if commit.merge_to_master?

    end
  end

  private

  def webhook_secret(payload)

  end
end