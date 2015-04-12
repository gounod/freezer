class Food < ActiveRecord::Base

  LOCATIONS = {"1" => "Kühlschrank", "2" => "Gefrierfach - Oben", "3" => "Gefrierfach - Mitte", "4" => "Gefrierfach - Unten"}

  def location_name
    if location.present?
      Food::LOCATIONS[location]
    else
      "- unbenutzt -"
    end
  end

end
