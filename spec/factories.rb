FactoryGirl.define do

  factory :bird, class: Bird  do |a|
    name 'Duck'
    family 'Availabile in eastzone'
    continents ["Africa"]
    added  Time.now.strftime("%Y-%m-%d")
    visible true
    created_at Time.now
    updated_at Time.now
  end

  factory :bird_obj, class: Bird  do |a|
    name 'Duck'
    family 'Availabile in WestZone'
    added  Time.now.strftime("%Y-%m-%d")
    visible true
    created_at Time.now
    updated_at Time.now
  end

  factory :invalid_bird_array, class: Bird  do |a|
    name 'Duck'
    family 'Availabile in WestZone'
    added  Time.now.strftime("%Y-%m-%d")
    visible true
    created_at Time.now
    updated_at Time.now
    continents ["Africa Antaritica"]
  end

  factory :valid_continents, class: Bird  do |a|
    name 'Duck'
    family 'Availabile in WestZone'
    added  Time.now.strftime("%Y-%m-%d")
    visible true
    created_at Time.now
    updated_at Time.now
    continents ["Africa","Antarctica"]
  end

  factory :in_valid_continents, class: Bird  do |a|
    name 'Duck'
    family 'Availabile in WestZone'
    added  Time.now.strftime("%Y-%m-%d")
    visible true
    created_at Time.now
    updated_at Time.now
    continents ["Africa","Apple"]
  end

end
