require 'http_codes'
module Api
  module Bird
    class BirdsController < ApplicationController
      include Roar::Rails::ControllerAdditions
      respond_to :json

      # It generates all the birds list http://localhost:3000/birds [GET]
      def birds_list
        birds = ::Bird.all
        render status: HttpCodes::OK,json: birds.extend(BirdRepresenter).to_a.as_json unless birds.empty?
        render status: HttpCodes::OK,json: {} if birds.empty?
      end

      # It  adds the new Bird to birds Db  http://localhost:3000/birds [POST]
      def add_bird
        bird_obj = bird_params
        continent = params['continents']
        unless continent.nil?
           continent = continent.split(',').map { |v| v.strip } if continent.is_a?(String)
            if continent.is_a?(Array) && !continent.blank?
              continent = continent[0].split(',').map { |v| v.strip } if continent.size==1
            end
        else
          continent =[]
        end
        bird_obj['continents'] =  continent
        bird = ::Bird.new(bird_obj)
        begin
          bird.save!
          bird_obj = ::Bird.data(bird.id)
          render status: HttpCodes::CREATED, json: bird_obj.extend(BirdRepresenter).to_a.as_json
        rescue Mongoid::Errors::Validations
          error = Error.new.extend(ErrorRepresenter)
          error.message = "#{bird.errors.full_messages.join(";")}"
          error.validation_errors = bird.errors.to_hash
          render status: HttpCodes::BAD_REQUEST, json: error.as_json
        rescue Exception => e
          error = Error.new.extend(ErrorRepresenter)
          error.message = "#{e.class} #{e.message}\n #{e.backtrace}"
          render status: HttpCodes::BAD_REQUEST, json: error.as_json
        end
      end

      # It displays the specific bird http://localhost:3000/birds/:id(id of the bird) [GET]

      def display_bird
        bird = ::Bird.data(params[:id])
        if bird.nil?
          error = Error.new.extend(ErrorRepresenter)
          error.message = "Bird does not Exists"
          error.validation_errors = "Invalid Document Id "
          render status: HttpCodes::NOT_FOUND, json: error.as_json
        else
         render status: HttpCodes::OK, json: bird.extend(BirdRepresenter).to_a.as_json
        end
      end

      # It delete  the specific bird http://localhost:3000/birds/:id(id of the bird) [DELETE]

      def remove_bird
        bird = ::Bird.find(params[:id])
        if bird.nil?
          error = Error.new.extend(ErrorRepresenter)
          error.message = "Bird does not nound"
          error.validation_errors = "Invalid Bird  Id "
          render status: HttpCodes::NOT_FOUND, json: error.as_json
        else
          bird.destroy
          render status: HttpCodes::OK ,json: "OK".to_json
        end
      end

      private

      def bird_params
        params.permit(:name, :family, :visible,:continents)
      end

    end

  end
end



