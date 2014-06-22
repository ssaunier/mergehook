module ProjectsHelper
  def repo_url(repo)
    link_to repo, "https://github.com/#{repo}", target: :blank
  end

  def pivotal_tracker_project_url(id, tracker_projects)
    name = tracker_projects.select { |pair| pair.last == id.to_i }.first.try(:first)
    link_to name, "https://www.pivotaltracker.com/s/projects/#{id}", target: :blank
  end
end
