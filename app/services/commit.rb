class Commit

  MERGE_MESSAGE_PATTERN = /Merge pull request #(\d+) from [^\/]+\/(.*)/

  attr_reader :pull_request, :branch_name, :story_id, :merge_to_master
  alias_method :merge_to_master?, :merge_to_master

  def initialize(push_event_payload)
    @payload = push_event_payload
    @merge_to_master = false
    parse!
  end

  private

  def parse!
    return if empty_message?
    return unless master_branch?
    if MERGE_MESSAGE_PATTERN.match(message_first_line)
      @pull_request = $1.to_i
      @branch_name = $2
      # https://github.com/stevenharman/git_tracker/blob/master/lib/git_tracker/branch.rb#L7
      @story_id = branch_name[/#?(\d{6,10})/, 1]
      @merge_to_master = true
    end
  end

  def empty_message?
    @payload[:head_commit][:message].blank?
  end

  def master_branch?
    master_ref = "refs/heads/#{@payload[:repository][:master_branch]}"
    master_ref == @payload[:ref]
  end

  def message_first_line
    empty_message? ? nil : @payload[:head_commit][:message].split("\n").first
  end
end