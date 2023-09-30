# app/services/institution_service.rb

require 'httparty'

class InstitutionService
  BASE_URL = 'https://api.dane.gov.pl/institutions'
  HEADERS = {
    'X-API-VERSION' => '1.4',
    'Accept-Language' => 'en'
  }

  def self.fetch_and_save
    page = 1
    loop do
      response = HTTParty.get(BASE_URL, query: { page: page }, headers: HEADERS)
      data = JSON.parse(response.body)

      break if data["data"].empty?

      data["data"].each do |institution_data|
        attributes = institution_data["attributes"]
        Institution.create(
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
        )
      end

      page += 1
    end
  end
end


# app/services/institution_service.rb

require 'httparty'

class InstitutionService
  BASE_URL = 'https://api.dane.gov.pl/institutions'
  HEADERS = {
    'X-API-VERSION' => '1.4',
    'Accept-Language' => 'en'
  }

  def self.fetch_and_save
    page = 1
    per_page = 100  # Set the page size to the maximum allowed value

    loop do
      response = HTTParty.get(BASE_URL, query: { page: page, per_page: per_page }, headers: HEADERS)
      data = JSON.parse(response.body)

      break if data["data"].empty?

      data["data"].each do |institution_data|
        attributes = institution_data["attributes"]
        Institution.create(
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
        )
      end

      page += 1
    end
  end
end
