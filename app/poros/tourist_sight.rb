class TouristSight
  attr_reader :name, :address, :place_id, :id

  def initialize(tourist_sight_info)
    @name = tourist_sight_info[:properties][:name]
    @address = tourist_sight_info[:properties][:formatted]
    @place_id = tourist_sight_info[:properties][:place_id]
    @id = nil
  end
end