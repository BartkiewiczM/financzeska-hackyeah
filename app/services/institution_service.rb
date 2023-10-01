require_dependency 'institution_index'
require 'httparty'
require 'weaviate'

class InstitutionService
  BASE_URL = 'https://api.dane.gov.pl/institutions' unless defined?(BASE_URL)
  WEAVIATE_BASE_URL = 'https://financzeska-d5vrxbo2.weaviate.network' unless defined?(WEAVIATE_BASE_URL)
  HEADERS = {
    'X-API-VERSION' => '1.4',
    'Accept-Language' => 'en'
  } unless defined?(HEADERS)


  def self.fetch_and_save
    client = Weaviate::Client.new(
      url: 'https://financzeska-d5vrxbo2.weaviate.network',
      api_key: Rails.application.credentials.weaviate_api_key,
      model_service: :openai,
      model_service_api_key: Rails.application.credentials.open_ai_api_key
    )
    index = 1

    page = 1
    per_page = 100  # Set the page size to the maximum allowed value

    loop do
      response = HTTParty.get(BASE_URL, query: { page: page, per_page: per_page }, headers: HEADERS)
      data = JSON.parse(response.body)

      break if data["data"].empty?

      data["data"].each do |institution_data|
        attributes = institution_data["attributes"]

        # Save to your local database
        client.objects.create(
          class_name: 'Institution',
          properties: {
            slug: attributes["slug"],
            tel: attributes["tel"],
            notes: attributes["notes"],
            postal_code: attributes["postal_code"],
            abbreviation: attributes["abbreviation"],
            email: attributes["email"],
            regon: attributes["regon"],
            flat_number: attributes["flat_number"],
            city: attributes["city"],
            institution_type: attributes["institution_type"],
            title: attributes["title"],
            image_url: attributes["image_url"],
            street: attributes["street"],
            street_type: attributes["street_type"],
            description: attributes["description"],
            website: attributes["website"],
            street_number: attributes["street_number"],
            modified: attributes["modified"],
            created: attributes["created"],
            epuap: attributes["epuap"],
            fax: attributes["fax"],
            followed: attributes["followed"]
          }
        )

        pp index


        # Save to Weaviate
        weaviate_object = {
          class_name: 'Institution',
          properties: attributes
        }
      index += 1
      end

      page += 1
    end
  end
end
