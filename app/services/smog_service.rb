require 'httparty'
require 'weaviate'

class SmogService
  BASE_URL = 'https://public-esa.ose.gov.pl/api/v1/smog' unless defined?(BASE_URL)
  WEAVIATE_BASE_URL = 'https://financzeska-d5vrxbo2.weaviate.network' unless defined?(WEAVIATE_BASE_URL)
  HEADERS = {
    'Accept-Language' => 'en'
  } unless defined?(HEADERS)


  def self.fetch_and_save
    client = Weaviate::Client.new(
      url: WEAVIATE_BASE_URL,
      api_key: Rails.application.credentials.weaviate_api_key,
      model_service: :openai,
      model_service_api_key: Rails.application.credentials.open_ai_api_key
    )

    response = HTTParty.get(BASE_URL, headers: HEADERS)
    data = JSON.parse(response.body)

    objects_to_save = []

    data["smog_data"].each do |smog_data|
      school = smog_data["school"]
      data_values = smog_data["data"]

      # Add to the objects array
      objects_to_save << {
        class: 'School',
        properties: {
          name: school["name"],
          street: school["street"],
          post_code: school["post_code"],
          city: school["city"],
          longitude: school["longitude"],
          latitude: school["latitude"],
          humidity_avg: data_values["humidity_avg"],
          pressure_avg: data_values["pressure_avg"],
          temperature_avg: data_values["temperature_avg"],
          pm10_avg: data_values["pm10_avg"],
          pm25_avg: data_values["pm25_avg"],
          timestamp: smog_data["timestamp"]
        }
      }
    end

    client.objects.batch_create(objects: objects_to_save)
  end
end
