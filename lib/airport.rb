class Airport

	def initialize
		@capacity = 50
	end

	def planes
		@planes ||= []
	end

	def full
		@capacity == planes.count
	end

	def clear_for_landing(plane)
		raise if full
		raise if weather_status == :stormy
		plane.land!
		planes << plane
	end

	def clear_for_takeoff(plane)
		raise if weather_status == :stormy
		plane.take_off!
	end

	def weather_status
	end

end