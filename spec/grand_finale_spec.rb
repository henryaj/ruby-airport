# grand finale
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!

describe "The grand finale (last spec)" do
  it 'all planes can land and all planes can take off' do
    airport = Airport.new
    allow(airport).to receive(:weather_status).and_return("stormy")
    
    # Make six new planes, all flying by default
    plane1 = Plane.new
    plane2 = Plane.new
    plane3 = Plane.new
    plane4 = Plane.new
    plane5 = Plane.new
    plane6 = Plane.new

    the_planes = [plane1, plane2, plane3, plane4, plane5, plane6]

    # Planes cannot land until bad weather clears:
    the_planes.each do |plane|  
      expect{ airport.clear_for_landing(plane) }.to raise_error
    end

    allow(airport).to receive(:weather_status).and_return("sunny")

    # Now planes can land because the weather is good.
    the_planes.each { |plane| airport.clear_for_landing(plane) }

    # Expect the planes to report that they have landed.
    the_planes.each { |plane| expect(plane.status).to eq "landed" }

    # The planes take off again...    
    the_planes.each { |plane| airport.clear_for_takeoff(plane) }

    # And now should report that they air airborne.
    the_planes.each { |plane| expect(plane.status).to eq "flying" }
  end
end

