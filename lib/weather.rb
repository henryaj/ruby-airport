module Weather

	def weather_status
		seed = rand(9)
		seed > 6 ? "stormy" : "sunny"
	end

end