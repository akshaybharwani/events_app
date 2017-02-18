class UsersController < ApplicationController
  def index

  end

  def show
    @user = User.find(params[:id])
    #@events = @user.created_events.paginate(page: params[:page])
  end

  def attended_events
    @user  = User.find(params[:id])
    @events = @user.attended_events.paginate(page: params[:page])
    render 'show_events'
  end

  def created_events
    @user  = User.find(params[:id])
    @events = @user.created_events.paginate(page: params[:page])
    render 'show_events'
  end

end
