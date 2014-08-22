require 'airport'

# A plane currently in the airport can be requested to take off.
#
# No more planes can be added to the airport, if it's full.
# it is up to you how many planes can land in the airport and how that is implemented.
#
# If the airport is full then no planes can land
describe Airport do
  let(:airport)       { Airport.new }
  let(:plane)         { double :plane }
  
  context 'taking off and landing' do
    it 'a plane can land' do
      allow(airport).to receive(:weather_status).and_return("sunny")
      expect(plane).to receive(:land!)
      airport.clear_for_landing(plane)
    end
    
    it 'a plane can take off' do
      allow(airport).to receive(:weather_status).and_return("sunny")
      expect(plane).to receive(:take_off!)
      airport.clear_for_takeoff(plane)
    end
  end
  
  context 'traffic control' do
    it 'a plane cannot land if the airport is full' do
      full_airport = airport
      allow(airport).to receive(:weather_status).and_return("sunny")
      allow(plane).to receive(:land!)
      50.times { full_airport.clear_for_landing(plane) }
      expect{ full_airport.clear_for_landing(plane) }.to raise_error
    end
  end
    
    # Include a weather condition using a module.
    # The weather must be random and only have two states "sunny" or "stormy".
    # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
    # 
    # This will require stubbing to stop the random return of the weather.
    # If the airport has a weather condition of stormy,
    # the plane can not land, and must not be in the airport

  context 'weather conditions' do

    it 'weather can be stormy or sunny' do
      expect(airport.weather_status).to match (/stormy|sunny/)
    end

    it 'weather is sometimes stormy and sometimes sunny' do
      weather_log = []
      1000.times { weather_log << airport.weather_status }
      expect(weather_log.uniq).to contain_exactly("sunny", "stormy")
    end

    it 'a plane cannot take off when there is a storm brewing' do
      allow(airport).to receive(:weather_status).and_return("stormy")
      expect{ airport.clear_for_takeoff(plane) }.to raise_error
    end
    
    it 'a plane cannot land in the middle of a storm' do
      allow(airport).to receive(:weather_status).and_return("stormy")
      expect{ airport.clear_for_landing(plane) }.to raise_error
    end
  end
end

