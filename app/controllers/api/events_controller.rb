class Api::EventsController < Api::BaseController

  def create
    event = Event.create(event_params)
    if event.valid?
      render json: event.to_json, status: 201
    else
      render json: event.errors.to_json, status: 400
    end
  end

  def index
    render json: Event.all.order(:id).to_json, status: 200
  end

  def show
    event = Event.find_by(id: show_params)
    if event
      render json: event.to_json, status: 200
    else
      render json: {errors: "Failed to find event by that id"}, status: 404
    end
  end

  def repo_events
    events = Event.where(repo_id: repo_id)
    unless events.blank?
      render json: events.to_json, status: 200
    else
      render json: {errors: "Failed to find events"}, status: 404
    end
  end

  private

  def event_params
    params.permit(:event_type, :public, :repo_id, :actor_id)
  end

  def show_params
    params.permit(:id)
  end

  def repo_params
    params.permit(:repo_id)
  end
end