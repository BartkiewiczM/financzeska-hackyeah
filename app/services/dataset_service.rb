# app/services/dataset_service.rb

require 'httparty'

class DatasetService
  BASE_URL = 'https://api.dane.gov.pl/institutions'
  HEADERS = {
    'X-API-VERSION' => '1.4',
    'Accept-Language' => 'en'
  }

  def self.fetch_and_save_for_institution(institution)
    page = 1
    per_page = 100  # Set the page size to the maximum allowed value

    loop do
      # Fetch datasets for the specific institution using the provided endpoint structure
      response = HTTParty.get("#{BASE_URL}/#{institution.id}/datasets", query: { page: page, per_page: per_page }, headers: HEADERS)
      data = JSON.parse(response.body)

      break if data["data"].empty?

      data["data"].each do |dataset_data|
        debugger
        attributes = dataset_data["attributes"]
        Dataset.create(
          dataset_id: dataset_data["id"],  # Save the dataset id
          institution: institution,
          slug: attributes["slug"],
          downloads_count: attributes["downloads_count"],
          notes: attributes["notes"],
          license_condition_custom_description: attributes["license_condition_custom_description"],
          archived_resources_files_url: attributes["archived_resources_files_url"],
          url: attributes["url"],
          title: attributes["title"],
          image_url: attributes["image_url"],
          modified: attributes["modified"],
          created: attributes["created"],
          followed: attributes["followed"]
        )
      end

      page += 1
    end
  end

  def self.fetch_and_save_for_all_institutions
    Institution.all.each do |institution|
      fetch_and_save_for_institution(institution)
    end
  end
end
