class Bird
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  CONTINENT_LIST = ["Africa","Antarctica", "Asia", "Australia", "Europe", "North America", "South America"]

  field :name,                type: String
  field :family,              type: String
  field :continents,          type: Array, default: []
  field :added,               type: String, default: -> { Time.now.strftime("%Y-%m-%d") }
  field :visible,             type: Boolean, default: false

  validates :name, presence: true
  validates :family, presence: true

  validate :continents_data
  validate :duplicate_continents

  validates :continents,  presence: true,
                          length: { minimum: 1  ,message: 'At least one continent value is required'}

  scope :by_visible, -> {where(visible: true) }

  def self.all
    self.only(:name, :visible,:family,:continents,:added)
  end

  def self.data(id)
    self.only(:name, :visible,:family,:continents,:added).find(id)
  end


  private

  def duplicate_continents
    unless self.continents.nil? # make sure that continents values are exists
    duplicate_list = self.continents.find_all { |e| self.continents.count(e) > 1 } # check that any duplicate values exists
    errors.add(:continents,'Duplicate values  not allowed for continent') unless duplicate_list.empty? #  duplicate list empty  no error
    end
  end

  def continents_data
    self.continents.each do |continent|
      errors.add(:continents, "Valid continents  are: #{CONTINENT_LIST}") unless  CONTINENT_LIST.include?(continent)
    end unless self.continents.nil?
  end

 end
