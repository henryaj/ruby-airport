require_relative '../lib/weather.rb'
require_relative '../lib/plane.rb'

class Airport

	include Weather

	attr_reader :capacity

	AIRPORT_CAPACITY = 50

	def initialize
		@capacity = AIRPORT_CAPACITY
	end

	def planes
		@planes ||= []
	end

	def full?
		@capacity == planes.count
	end

	def clear_for_landing(plane)
		raise "Airport is full" if full?
		raise "Plane has already landed" if plane.status == "landed"
		raise "Weather is too bad to land" if weather_status != "sunny"
		plane.land!
		planes << plane
	end

	def clear_for_takeoff(plane)
		raise "Weather is too bad to take off" if weather_status == "stormy"
		plane.take_off!
		planes.delete(plane)
	end

end