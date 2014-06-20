require 'active_support/core_ext'
require_relative '../../app/services/commit.rb'

describe Commit do
  let(:merge_commit) do
    payload = ActiveSupport::HashWithIndifferentAccess.new(JSON.load('{"ref":"refs/heads/master","after":"64298d9908c9dfdcc1b4fec2627ae119837b2d85","before":"63c52105590bc62bcff21c9184fd812f95b35b17","created":false,"deleted":false,"forced":false,"compare":"https://github.com/ssaunier/test-finish-on-merge/compare/63c52105590b...64298d9908c9","commits":[{"id":"a8c89c80ac5cf12a1049999029238e605abc415b","distinct":false,"message":"Commit in feature branch","timestamp":"2014-06-20T11:00:15+02:00","url":"https://github.com/ssaunier/test-finish-on-merge/commit/a8c89c80ac5cf12a1049999029238e605abc415b","author":{"name":"Sebastien Saunier","email":"seb@saunier.me","username":"ssaunier"},"committer":{"name":"Sebastien Saunier","email":"seb@saunier.me","username":"ssaunier"},"added":[],"removed":[],"modified":["README"]},{"id":"64298d9908c9dfdcc1b4fec2627ae119837b2d85","distinct":true,"message":"Merge pull request #1 from ssaunier/feature-branch-91735638\n\nCommit in feature branch","timestamp":"2014-06-20T11:01:44+02:00","url":"https://github.com/ssaunier/test-finish-on-merge/commit/64298d9908c9dfdcc1b4fec2627ae119837b2d85","author":{"name":"Sébastien Saunier","email":"seb@saunier.me","username":"ssaunier"},"committer":{"name":"Sébastien Saunier","email":"seb@saunier.me","username":"ssaunier"},"added":[],"removed":[],"modified":["README"]}],"head_commit":{"id":"64298d9908c9dfdcc1b4fec2627ae119837b2d85","distinct":true,"message":"Merge pull request #1 from ssaunier/feature-branch-91735638\n\nCommit in feature branch","timestamp":"2014-06-20T11:01:44+02:00","url":"https://github.com/ssaunier/test-finish-on-merge/commit/64298d9908c9dfdcc1b4fec2627ae119837b2d85","author":{"name":"Sébastien Saunier","email":"seb@saunier.me","username":"ssaunier"},"committer":{"name":"Sébastien Saunier","email":"seb@saunier.me","username":"ssaunier"},"added":[],"removed":[],"modified":["README"]},"repository":{"id":21031698,"name":"test-finish-on-merge","url":"https://github.com/ssaunier/test-finish-on-merge","description":"","watchers":0,"stargazers":0,"forks":0,"fork":false,"size":0,"owner":{"name":"ssaunier","email":"seb@saunier.me"},"private":false,"open_issues":0,"has_issues":true,"has_downloads":true,"has_wiki":true,"created_at":1403254721,"pushed_at":1403254904,"master_branch":"master"},"pusher":{"name":"ssaunier","email":"seb@saunier.me"}}'))
    Commit.new(payload)
  end

  describe "#pull_request" do
    it "should return the Pull Request number" do
      expect(merge_commit.pull_request).to eq 1
    end
  end

  describe "#branch_name" do
    it "should return the branch name" do
      expect(merge_commit.branch_name).to eq "feature-branch-91735638"
    end
  end

  describe "#story_id" do
    it "should extract the story id from the branch name" do
      expect(merge_commit.story_id).to eq "91735638"
    end
  end

  describe "#merge_to_master?" do
    it "should tell that the merge_commit has been merged to the master branch" do
      expect(merge_commit.merge_to_master?).to eq true
    end
  end
end