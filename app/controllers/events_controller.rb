class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
    event_params = params.require(:event).permit(:name,:date,:time,:category,:remarks)
    @event = Event.new event_params
    @event.user = current_user
    if @event.save
      redirect_to calendar_show_path, notice: 'Event Added'
    else
      render 'schedules/show'
    end
  end

  def destroy
    event = Event.find params[:id]
    if event.user==current_user
      event.destroy
      redirect_to calendar_show_path, notice: 'Event deleted!' ,status: 303
    else
      redirect_to root_path, alert: 'access denied'
    end
  end

  def run_schedule
    events = current_user.schedules.first.tasks
    events.each do |event|
      Event.addEvent(event.day,event.time,event.name,event.category,event.remark,current_user)
    end
    redirect_to calendar_show_path, notice: 'Schedule Added'
  end
end