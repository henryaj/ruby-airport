require 'airport'
require 'plane'
require 'weather'

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
      expect(plane).to receive(:land!)
      airport.clear_for_landing(plane)
    end
    
    it 'a plane can take off' do
      expect(plane).to receive(:take_off!)
      airport.clear_for_takeoff(plane)
    end
  end
  
  context 'traffic control' do
    it 'a plane cannot land if the airport is full' do
      full_airport = airport
      allow(plane).to receive(:land!)
      50.times { full_airport.clear_for_landing(plane) }
      expect{ full_airport.clear_for_landing(plane) }.to raise_error
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

      it 'a plane cannot take off when there is a storm brewing' do
        allow(airport).to receive(:weather_status).and_return(:stormy)
        expect{ airport.clear_for_takeoff(plane) }.to raise_error
      end
      
      it 'a plane cannot land in the middle of a storm' do
        allow(airport).to receive(:weather_status).and_return(:stormy)
        expect{ airport.clear_for_landing(plane) }.to raise_error
      end
    end
  end
end

# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should have its status changed to "landed"
#
# When the plane takes of from the airport, the plane's status should become "flying"
describe Plane do

  let(:plane) { Plane.new }
  
  it 'has a flying status when created' do
    expect(plane.status).not_to be nil
  end
  
  it 'has a flying status when in the air' do
    expect(plane.status).to eq "flying"
  end
  
  it 'can land' do
    expect(plane).to receive(:land!)
    plane.land!
  end
  
  it 'can take off' do
    expect(plane).to receive(:take_off!)
    plane.land!; plane.take_off!
  end
  
  it 'changes its status to landed after landing' do
    plane.land!
    expect(plane.status).to eq "landed"
  end

  it 'changes its status to flying after taking off' do
    plane.land!; plane.take_off!
    expect(plane.status).to eq "flying"
  end
end

# grand finale
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!

describe "The grand finale (last spec)" do
  xit 'all planes can land and all planes can take off' do
  end
end

