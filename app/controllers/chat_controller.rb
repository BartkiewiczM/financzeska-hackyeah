class ChatController < ApplicationController
  def index
    @messages = Message.all
  end

  def send_message
    user_message = Message.create(content: params[:content], from_user: true)
    chat_history = Message.order(created_at: :desc).limit(20).reverse

    institutions_database_response = params[:useInstitutionsDatabase] == true ? check_institiutions_database(user_message.content) : ''
    smog_database_response = params[:useSmogDatabase] == true ? check_smog_database(user_message.content) : ''

    response_content = ContentWriter.write_draft_post(params[:content], chat_history, institutions_database_response + smog_database_response)
    response_message = Message.create(content: response_content, from_user: false)

    render json: { response: response_message.content }
  end

  private

  def check_institiutions_database(user_message)
    setup = setup_for_queries

    body = {
      query: "{ Get { Institution(nearText: { concepts: [\"#{user_message}\"] }, limit: 3) { city email regon notes slug } } }"
    }

    setup[:request].body = body.to_json
    response = setup[:http].request(setup[:request])

    response.body
  end

  def check_smog_database(user_message)
      setup = setup_for_queries

      body = {
        query: "{ Get { School(nearText: { concepts: [\"#{user_message}\"] }, limit: 1) { city name post_code street temperature_avg humidity_avg pressure_avg pm10_avg pm25_avg timestamp } } }"
      }

      setup[:request].body = body.to_json
      response = setup[:http].request(setup[:request])

      response.body
  end

  def setup_for_queries
      require 'net/http'
      require 'json'

      uri = URI('https://financzeska-d5vrxbo2.weaviate.network/v1/graphql')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.path, {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{Rails.application.credentials.weaviate_api_key}",
        'X-Openai-Api-Key' => Rails.application.credentials.open_ai_api_key
      })

      { request: request, http: http }
  end
end
