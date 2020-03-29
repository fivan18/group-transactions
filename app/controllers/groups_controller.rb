class GroupsController < ApplicationController
  before_action :authenticate_user!
  
  def new; end

  def create
    group = current_user.groups.create(group_params)
    if group
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

    def group_params
      params.require(:group).permit(:name, :avatar)
    end
end