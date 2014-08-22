module Weather

	def weather_status
		seed = rand(9)
		seed > 7 ? "stormy" : "sunny"
	end

end