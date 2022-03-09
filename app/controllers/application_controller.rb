require 'pry'

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/buildings" do
    buildings = Building.all
    # buildings.to_json
    buildings.to_json(include: [:architect, :city])
  end

  

  get '/buildings/:id' do
    building = Building.find(params[:id])
    building.to_json
  end

  delete '/buildings/:id' do
    building = Building.find(params[:id])
    building.destroy
    building.to_json
  end

  post '/buildings' do
    new_building = Building.create(
      name: params[:name],
      city_id: params[:city_id],
      architect_id: params[:architect_id],
      opened: params[:opened],
      image_url: params[:image_url],
      description: params[:description],
      map_location: params[:map_location],
    )
    new_building.to_json
  end

  ### Version 2
  get '/architects/:id/info' do
    architect = Architect.find(params[:id])
    info = {
      number: architect.number_of_buildings,
      locations: architect.building_locations,
      oldest: architect.oldest_building,
      newest: architect.newest_building
    }
    info.to_json
  end 

  get '/cities/:id/info' do
    city = City.find(params[:id])
    info = {
      city_buildings: city.how_many,
      oldest: city.oldest_building_in_city,
      newest: city.newest_building_in_city
    }
    info.to_json
  end
end 
