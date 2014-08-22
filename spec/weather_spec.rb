require 'weather'

describe Weather do

	let(:airport) { Airport.new }

	it 'weather can be stormy or sunny' do
	  expect(airport.weather_status).to match (/stormy|sunny/)
	end

	it 'weather is sometimes stormy and sometimes sunny, and never anything other than stormy or sunny' do
	  weather_log = []
	  1000.times { weather_log << airport.weather_status }
	  expect(weather_log.uniq).to contain_exactly("sunny", "stormy")
	end

end