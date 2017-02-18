class AttendanceRelationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:attended_event_id])
    current_user.attend_event(@event)
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
  end

  def destroy
    @event = AttendanceRelation.find(params[:id]).attended_event
    current_user.unattend_event(@event)
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
  end
end
