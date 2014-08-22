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
		plane.land!
		planes << plane
	end

	def clear_for_takeoff(plane)
		plane.take_off!
	end

end