require 'plane'

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
    expect(plane.methods).to include(:land!)
  end
  
  it 'can take off' do
    plane.land!
    expect(plane.methods).to include(:take_off!)
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