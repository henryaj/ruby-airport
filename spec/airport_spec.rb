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
  let(:flying_plane)  { double :plane, { :status => "flying", :land! => nil }}
  let(:landed_plane)  { double :plane, { :status => "landed", :take_off! => nil}}

  context 'basic airport properties' do
    it 'knows if it is full' do
      expect(airport.full?).to eq false
      allow(airport).to receive(:weather_status).and_return("sunny")
      50.times { airport.clear_for_landing(flying_plane) }
      expect(airport.full?).to eq true
    end

    it 'knows its capacity' do
      expect(airport.capacity).to eq Airport::AIRPORT_CAPACITY
    end

    it 'has an empty array for planes by default' do
      expect(airport.planes).to eq []
    end

    it 'knows what planes are in the airport' do
      allow(airport).to receive(:weather_status).and_return("sunny")
      airport.clear_for_landing(flying_plane)
      expect(airport.planes).to eq [flying_plane]
    end
  end

  context 'taking off and landing' do
    it 'can command a plane to land' do
      allow(airport).to receive(:weather_status).and_return("sunny")
      expect(flying_plane).to receive(:land!)
      airport.clear_for_landing(flying_plane)
    end
    
    it 'can command a plane to take off' do
      allow(airport).to receive(:weather_status).and_return("sunny")
      expect(landed_plane).to receive(:take_off!)
      airport.clear_for_takeoff(landed_plane)
    end

    it 'stashes a plane in the planes array when it lands' do
      allow(airport).to receive(:weather_status).and_return("sunny")
      airport.clear_for_landing(flying_plane)
      expect(airport.planes).to eq([flying_plane])
    end

    it 'removes the plane from the planes array when it takes off' do
      allow(airport).to receive(:weather_status).and_return("sunny")
      airport.clear_for_landing(flying_plane)
      allow(flying_plane).to receive(:take_off!)
      airport.clear_for_takeoff(flying_plane)
      expect(airport.planes).to eq([])
    end
  end
  
  context 'traffic control' do
    it 'will not allow a plane to land if the airport is full' do
      full_airport = airport
      allow(airport).to receive(:weather_status).and_return("sunny")
      50.times { full_airport.clear_for_landing(flying_plane) }
      expect{ full_airport.clear_for_landing(flying_plane) }.to raise_error
    end
  end

  context 'weather conditions' do

    it 'will not allow a plane to take off when there is a storm brewing' do
      allow(airport).to receive(:weather_status).and_return("stormy")
      expect{ airport.clear_for_takeoff(plane) }.to raise_error
    end
    
    it 'will not allow a plane to land in the middle of a storm' do
      allow(airport).to receive(:weather_status).and_return("stormy")
      expect{ airport.clear_for_landing(plane) }.to raise_error
    end
  end
end

