require 'weather'

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
		raise if full?
		raise if weather_status != "sunny"
		plane.land!
		planes << plane
	end

	def clear_for_takeoff(plane)
		raise if weather_status == "stormy"
		plane.take_off!
		planes.delete(plane)
	end

end