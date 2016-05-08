class House < ActiveRecord::Base
  validates :description, :user_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :longitude, numericality: { less_than_or_equal_to: 0 }, presence: true

  belongs_to :user

  scope :filter_by_description, lambda { |description|
    where("lower(description) LIKE ?", "%#{description.downcase}%")
  }
  scope :filter_by_geolocation, lambda { |latitude, longitude, radio|
    where("ACOS(SIN(?)*SIN(radians(latitude)) + COS(?)*COS(radians(latitude))*COS(radians(longitude)- ?)) * 6371 <= ?", latitude,latitude,longitude,radio.to_i*1000)
  }

  def self.search(params = {})
    if params[:description]
      houses =  House.filter_by_description(params[:description])
    elsif params[:latitude] && params[:longitude] && params[:radio]
      houses = House.filter_by_geolocation(params[:latitude], params[:longitude], params[:radio])
    else
      houses = House.all
    end
    houses
  end
end
