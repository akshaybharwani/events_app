class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # Only Signed In users can CRUD posts.
  before_action :authenticate_user!, only: [:new, :create, :destroy] # We can add an exception if we want.
  # GET /events
  # GET /events.json
  def index
    # @events = Event.all.paginate(page: params[:page])
    @filterrific = initialize_filterrific(
        Event,
        params[:filterrific],
        :select_options => {
            with_event_category_id: EventCategory.options_for_select
        }
    ) or return
    @events = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    commontator_thread_show(@event)
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
    @event = current_user.created_events.build(event_params)

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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :description, :picture, :start_date, :event_category_id, :location)
  end
end
