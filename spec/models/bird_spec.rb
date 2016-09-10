require 'rails_helper'
require 'spec_helper'
require 'pry'
describe Bird do
  before :each do
    @bird = FactoryGirl.build(:bird)
  end



  after :each do
    # this test uses the db storage for uniqueness testing, so need to clean between runs
    DatabaseCleaner.clean
  end

  describe "#valid" do
    it "should require a name" do
      expect(@bird.valid?).to eq(true)
      @bird.name = nil
      expect(@bird.valid?).to eq(false)
    end

    it "should require a family" do
      expect(@bird.valid?).to eq(true)
      @bird.family = nil
      expect(@bird.valid?).to eq(false)
    end

    it "should require a continents" do
      expect(@bird.valid?).to eq(true)
      @bird.continents = nil
      expect(@bird.valid?).to eq(false)
    end

    it "should not validate if the  a continents are empty" do
      expect(@bird.valid?).to eq(true)
      @bird.continents = []
      expect(@bird.valid?).to eq(false)
    end

    it "should not validate if  duplicate value find in continents" do
      expect(@bird.valid?).to eq(true)
      @bird.continents << "Africa"
      expect(@bird.valid?).to eq(false)
    end

    it "should not validate if  the given continent has not exists" do
      expect(@bird.valid?).to eq(true)
      @bird.continents << "Apple"
      expect(@bird.valid?).to eq(false)
    end



  end


end
