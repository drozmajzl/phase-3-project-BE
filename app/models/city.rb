class City < ActiveRecord::Base
    has_many :buildings
    has_many :architects, through: :buildings

    # How many architects have buildings in that city and how many do they each have?

    def how_many
        arr = []
        self.architects.uniq.map do |a| 
            arr2 = self.buildings.select{|b| b.architect.full_name == a.full_name}
            arr << 
            {
            architect_name: a.full_name,
            buildings: arr2.map{|a| a.name} 
            }
        end
        arr
    end

    #     What is the oldest building in this city

    def oldest_building_in_city
        x = self.buildings.min_by { |building| building.opened }
        x.opened
    end

    #     What is the newest building in this city?

    def newest_building_in_city
        x = self.buildings.max_by { |building| building.opened }
        x.opened
    end
    
end