class ProjectsController < ApplicationController
  before_action :set_project, only: [:destroy, :show]

  def index
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = ProjectCreator.new(project_params).run(current_user)
    if @project.persisted?
      redirect_to project_path(@project.id)
    else
      render :new
    end
  end

  def show

  end

  def destroy
    GithubUnsubscriber.new(@project).run(current_user)
    @project.destroy
    redirect_to projects_path
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:repo, :tracker_project_id)
  end
end
