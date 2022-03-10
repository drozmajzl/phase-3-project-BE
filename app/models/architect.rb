class Architect < ActiveRecord::Base
    has_many :buildings
    has_many :cities, through: :buildings
    
    def number_of_buildings
        self.buildings.count
    end

    def building_locations
        city_array = []
        self.cities.map {|city| city_array << city.name} 
        city_array
    end

    def oldest_building
        x = self.buildings.min_by { |building| building.opened }
        x.opened
    end

    def newest_building
        x = self.buildings.max_by { |building| building.opened }
        x.opened
    end
end