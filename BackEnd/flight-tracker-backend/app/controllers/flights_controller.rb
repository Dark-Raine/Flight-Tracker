class FlightsController < ApplicationController
@@key = ""

  def getflights
    response = Unirest.post "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/pricing/v1.0",
      headers:{
        "X-RapidAPI-Key" => "d7ed621b7amsh6be8bc126d88794p1b0e91jsn7176abcd046e",
        "Content-Type" => "application/json",
        "accept" => "application/json"
      },
      parameters: params[:flightinfo]
        # "inboundDate" => "2019-03-27",
        # "cabinClass" => "economy",
        # "children" => 0,
        # "infants" => 0,
        # "groupPricing" => "false",
        # "country" => "UK",
        # "currency" => "GBP",
        # "locale" => "en-UK",
        # "originPlace" => "LHR-sky",
        # "destinationPlace" => "HKG-sky",
        # "outboundDate" => "2019-03-15",
        # "adults" => 1
      byebug
      @@key = Flight.getsessionkey(response.headers[:location])

      puts response
      # render json: retrieveflights
      redirect_to getflights_results_path
    end

    def retrieveflights
      if @@key != ""
        toplace = @@key

      end
      response = Unirest.get "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/pricing/uk2/v1.0/#{@@key}?pageIndex=0&pageSize=10",
        headers:{
          "X-RapidAPI-Key" => "d7ed621b7amsh6be8bc126d88794p1b0e91jsn7176abcd046e",
          "Content-Type" => "application/json",
          "accept" => "application/json"
        }
        # parameters:{
        #   sessionkey: "dea5adff-cd61-4104-914b-c909e640d3cb"
        # }
      # puts response
      # byebug
      render json: response.body
      # response.body
    end

  end
