class GroupsController < ApplicationController
  before_action :authenticate_user!
  
  def new; end

  def show
    id = params[:id]
    if Group.exists?(id)
      @transactions = Group.find(id).transactions
      @amount = amount_transactions(@transactions)
    else
      redirect_to root_path
    end
  end

  def create
    group = current_user.groups.create(group_params)
    if group
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def index
    @groups = Group.all
  end

  private

    def group_params
      params.require(:group).permit(:name, :avatar)
    end
end