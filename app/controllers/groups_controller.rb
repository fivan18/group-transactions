class GroupsController < ApplicationController
  before_action :store_user_location!, only: [:show, :index], 
                                       if: :storable_location?
  before_action :authenticate_user!
  
  def new
    @group = Group.new
  end

  def show
    id = params[:id]
    if Group.exists?(id)
      @transactions = Group.find(id).sorted_transactions
      @amount = amount_transactions(@transactions)
    else
      redirect_to root_path
    end
  end

  def create
    @group = current_user.groups.create(group_params)
    if @group.id
      redirect_to stored_location_for(:user) || root_url
    else
      render 'new'
    end
  end
  
  def index
    @groups = Group.all
  end

  private

  private

    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end

    def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:user, request.fullpath)
    end

    def group_params
      params.require(:group).permit(:name, :avatar)
    end
end