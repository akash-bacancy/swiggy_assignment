class Event < ApplicationRecord
	validates :event_type, inclusion: { in: %w(PushEvent ReleaseEvent WatchEvent),
    message: "%{value} is not a valid event type" }
end
