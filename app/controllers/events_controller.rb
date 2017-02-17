class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # Only Signed In users can CRUD posts.
  before_action :authenticate_user!, only: [:new, :create, :destroy, :attend] # We can add an exception if we want.
  # GET /events
  # GET /events.json
  def index
    @events = Event.all.paginate(page: params[:page])
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.events.build(event_params)

    if @event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to @event
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      flash[:notice] = 'Event was successfully updated.'
      redirect_to @event
    else
      render :edit
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    flash[:notice] = 'Event deleted'
    redirect_to request.referrer || root_url
  end

  def attend
    @event = Event.find(params[:id])
    @event.upvote_by current_user
    redirect_to :back
  end

  def unattend
    @event = Event.find(params[:id])
    @event.downvote_by current_user
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :picture)
    end
end
