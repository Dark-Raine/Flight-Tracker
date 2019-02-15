class Api::V1::UsersController < ApplicationController

    def create
      # byebug
      @user = User.find_or_create_by(username: params[:username])
      render json: @user
    end

    def show
      @user = User.find(params[:id])
      render json: @user
    end

    # def getflights
    #   response = Unirest.post "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/pricing/v1.0",
    #     headers:{
    #       "X-RapidAPI-Key" => "d7ed621b7amsh6be8bc126d88794p1b0e91jsn7176abcd046e",
    #       "Content-Type" => "application/json",
    #       "accept" => "application/json"
    #     },
    #     parameters:{
    #       "inboundDate" => "2019-03-10",
    #       "cabinClass" => "economy",
    #       "children" => 0,
    #       "infants" => 0,
    #       "groupPricing" => "false",
    #       "country" => "UK",
    #       "currency" => "GBP",
    #       "locale" => "en-UK",
    #       "originPlace" => "SFO-sky",
    #       "destinationPlace" => "LHR-sky",
    #       "outboundDate" => "2019-02-15",
    #       "adults" => 1
    #     }
    #     puts response
    #     # retrieve_flights
    #   end
    #
    #   def retrieveflights
    #     response = Unirest.get "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/pricing/uk2/v1.0/20e3663c-7009-4136-b9f3-be69ab45acd3?pageIndex=0&pageSize=10",
    #       headers:{
    #         "X-RapidAPI-Key" => "d7ed621b7amsh6be8bc126d88794p1b0e91jsn7176abcd046e",
    #         "Content-Type" => "application/json",
    #         "accept" => "application/json"
    #       },
    #       parameters:{
    #         sessionkey: "0b6c35a4-28dc-4f94-9610-fbf31ab163ad"
    #       }.as_json()
    #     puts response
    #     render json: response.body
    #     byebug
    #   end

    private

    def user_params
      params.permit(:user).require(:username)
    end

end
