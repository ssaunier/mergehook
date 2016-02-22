require "set"
require "pivotal-tracker"

module Tracker
  class Account
    def initialize(token)
      ::PivotalTracker::Client.token = token
      ::PivotalTracker::Client.use_ssl = true
    end

    def projects
      ::PivotalTracker::Project.all
    end
  end

  class Project
    def initialize(token, project_id)
      ::PivotalTracker::Client.token = token
      ::PivotalTracker::Client.use_ssl = true
      @project = ::PivotalTracker::Project.find(project_id)
    end

    def story(story_id)
      Story.new(@project, story_id)
    end

    def self.from_project(project)
      Tracker::Project.new(project.user.pivotal_tracker_api_token, project.tracker_project_id.to_i)
    end
  end

  class Story
    def initialize(project, story_id)
      @story = project.stories.find(story_id.to_i)
    end

    def deliver
      if %w(unscheduled unstarted started finished).include?(@story.current_state)
        @story.update(current_state: "delivered")
      end      
    end

    def finish
      if %w(unscheduled unstarted started).include?(@story.current_state)
        @story.update(current_state: "finished")
      end
    end

    def add_label(label)
      labels = label_set
      labels << label
      update_labels(labels)
    end

    def remove_label(label)
      labels = label_set
      labels.delete(label)
      update_labels(labels)
    end

    def add_note(text)
      @story.notes.create text: text
    end

    private

    def label_set
      flat_labels = @story.labels
      Set.new(flat_labels.blank? ? [] : flat_labels.split(",").map(&:strip))
    end

    def update_labels(labels)
      label_array = labels.to_a.compact
      label_array.sort! if label_array.any?
      @story.update(labels: label_array.join(","))
    end
  end
end