require 'rails_helper'
require 'spec_helper'
require 'http_codes'

module Api
  module Bird
    include HttpCodes
    describe BirdsController  do

      JSON_CONTENT = "application/json; charset=utf-8"
      describe "defaults" do
              before :each do
                get "birds_list"
              end
                it "should return a success response code" do
                  expect(response.status).to eq(OK)
                end
                it "should return the proper content type" do
                  expect(response.headers["Content-Type"]).to eq(JSON_CONTENT)
                end

                it "should not be null" do
                  expect(ActiveSupport::JSON.decode(response.body)).not_to eq(nil)
                end



      end

      describe "POST /" do
        it "should return a Bad request  response code when we are not sending the continent" do
          bird = FactoryGirl.build(:bird_obj)
          bird.extend(BirdRepresenter)
          post "add_bird", bird.to_hash
          expect(response.status).to eq(BAD_REQUEST)
        end

        it "should return Success   response code" do
          bird = FactoryGirl.build(:bird)
          bird.extend(BirdRepresenter)
          post "add_bird", bird.to_hash
          expect(response.status).to eq(CREATED)
        end

        it "should return Failure code when user has given the wrong continents" do
          bird = FactoryGirl.build(:invalid_bird_array)
          bird.extend(BirdRepresenter)
          post "add_bird", bird.to_hash
          expect(response.status).to eq(BAD_REQUEST)
        end

        it "should return Failure code when user has given the wrong continents" do
          bird = FactoryGirl.build(:invalid_bird_array)
          bird.extend(BirdRepresenter)
          post "add_bird", bird.to_hash
          expect(response.status).to eq(BAD_REQUEST)
        end

        it "should return Failure code when invalid continents" do
          bird = FactoryGirl.build(:in_valid_continents)
          bird.extend(BirdRepresenter)
          post "add_bird", bird.to_hash
          expect(response.status).to eq(BAD_REQUEST)
        end

        it "should  accept when multiple continents given" do
          bird = FactoryGirl.build(:valid_continents)
          bird.extend(BirdRepresenter)
          post "add_bird", bird.to_hash
          expect(response.status).to eq(CREATED)
        end

        it "should return the proper content type" do
          bird = FactoryGirl.build(:valid_continents)
          bird.extend(BirdRepresenter)
          post "add_bird", bird.to_hash
          expect(response.headers["Content-Type"]).to eq(JSON_CONTENT)
          #response.headers["Content-Type"].should eq(JSON_CONTENT)
        end
        it "should return a valid  Bird name " do
          bird = FactoryGirl.build(:valid_continents)
          bird.extend(BirdRepresenter)
          post "add_bird", bird.to_hash
          bird_obj = JSON.parse(response.body)
          expect(bird_obj[0]['id']).not_to eq(nil)
          expect(bird_obj[0]['name']).to eq('Duck')
          expect(bird_obj[0]['continents']).to eq(["Africa","Antarctica"])
          expect(response.status).to eq(CREATED)
        end
      end



      describe "GET /:id" do
        before :each do
          @bird = FactoryGirl.build(:bird)
          @bird.extend(BirdRepresenter).save!
          @bird.save!
        end
        it "should return a success response code" do
          get(:display_bird, id: @bird.id)
          expect(response.status).to eq(OK)
        end
        it "should return the proper content type" do
          get(:display_bird, id: @bird.id)
          expect(response.headers["Content-Type"]).to eq(JSON_CONTENT)
        end
        it "should return a valid response body" do
          get(:display_bird, id: @bird.id)
          obj = JSON.parse(response.body)
          validate_bird_response_content(obj,@bird)
        end

        it "should return a not found response code" do
          get(:display_bird, id: '12323123123213')
          expect(response.status).to eq(NOT_FOUND)
        end

      end

      describe "DELETE /:id" do
        before :each do
          @bird = FactoryGirl.build(:bird)
          @bird.extend(BirdRepresenter)
          @bird.save!
        end

        it "should return a success response code" do
          delete(:remove_bird, id: @bird.id)
          expect(response.status).to eq(OK)
        end

        it "should return a not found  response code" do
          delete(:remove_bird, id: '12345678')
          expect(response.status).to eq(NOT_FOUND)
        end
      end

      def validate_bird_response_content(response, bird)
        expect(response[0]['name']).to eq(bird.name)
        expect(response[0]['family']).to eq(bird.family)
        expect(response[0]['id']).to eq(bird.id.to_s)
        expect(response[0]['visible']).to eq(bird.visible)
        expect(response[0]['continents']).to eq(bird.continents)
        expect(response[0]['added']).to eq(bird.added)
      end
    end
  end
end






