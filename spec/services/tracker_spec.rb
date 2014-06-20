require_relative '../../app/services/tracker.rb'

module Tracker
  describe Story do
    let(:stories) do
      stories = double("stories")
      allow(stories).to receive(:find) { @mock_story }
      stories
    end

    let (:project) do
      project = double("project")
      allow(project).to receive(:stories) { stories }
      project
    end
    let (:story) do
      Story.new(project, 123)
    end

    describe "#finish" do
      it "should finish an unscheduled story" do
        expect_finish("unscheduled")
      end

      it "should finish an unstarted story" do
        expect_finish("unstarted")
      end

      it "should finish an started story" do
        expect_finish("started")
      end

      def expect_finish(from_state)
        @mock_story = double("mock_story")
        expect(@mock_story).to receive(:current_state) { from_state }
        expect(@mock_story).to receive(:update)
        story.finish
      end
    end

    describe "#add_label" do
      before(:each) do
        @mock_story = double("mock_story")
      end

      context "Story does not have any label yet" do
        it "should add a label to the story" do
          expect_label_added "foo", nil, "foo"
        end
      end

      context "Story has already one label" do
        it "should add a label to the story" do
          expect_label_added "bar", "foo", "bar,foo"
        end
      end

      context "Story has already two labels" do
        it "should add a label to the story" do
          expect_label_added "bar,baz", "foo", "bar,baz,foo"
        end
      end

      def expect_label_added(label, before, after)
        expect(@mock_story).to receive(:labels) { before }
        expect(@mock_story).to receive(:update).with(labels: after)
        story.add_label label
      end
    end
  end
end