require 'weaviate'

client = Weaviate::Client.new(
    url: 'https://financzeska-d5vrxbo2.weaviate.network',  # Replace with your endpoint
    api_key: Rails.application.credentials.weaviate_api_key,
    model_service: :openai, # Service that will be used to generate vectors. Possible values: :openai, :azure_openai, :cohere, :huggingface, :google_palm
    model_service_api_key: Rails.application.credentials.open_ai_api_key # API key for the model service
)

client.schema.create(
    class_name: 'Institution',
    description: 'Information about an institution',
    properties: [
        { dataType: ["text"], description: "Slug of the institution", name: "slug" },
        { dataType: ["text"], description: "Telephone number", name: "tel" },
        { dataType: ["text"], description: "Notes", name: "notes" },
        { dataType: ["text"], description: "Postal code", name: "postal_code" },
        { dataType: ["text"], description: "Abbreviation", name: "abbreviation" },
        { dataType: ["text"], description: "Email address", name: "email" },
        { dataType: ["text"], description: "Regon number", name: "regon" },
        { dataType: ["text"], description: "Flat number", name: "flat_number" },
        { dataType: ["text"], description: "City", name: "city" },
        { dataType: ["text"], description: "Type of the institution", name: "institution_type" },
        { dataType: ["text"], description: "Title of the institution", name: "title" },
        { dataType: ["text"], description: "Image URL", name: "image_url" },
        { dataType: ["text"], description: "Street name", name: "street" },
        { dataType: ["text"], description: "Street type", name: "street_type" },
        { dataType: ["text"], description: "Description", name: "description" },
        { dataType: ["text"], description: "Website URL", name: "website" },
        { dataType: ["text"], description: "Street number", name: "street_number" },
        { dataType: ["text"], description: "Modified date", name: "modified" },
        { dataType: ["text"], description: "Creation date", name: "created" },
        { dataType: ["text"], description: "EPUAP", name: "epuap" },
        { dataType: ["text"], description: "Fax number", name: "fax" },
        { dataType: ["boolean"], description: "Followed status", name: "followed" }
    ],
    vectorizer: "text2vec-openai"
)

client.schema.create(
    class_name: 'School',
    description: 'Information about a school and its associated smog data',
    properties: [
        { dataType: ["text"], description: "Name of the school", name: "name" },
        { dataType: ["text"], description: "Street of the school", name: "street" },
        { dataType: ["text"], description: "Postal code of the school", name: "post_code" },
        { dataType: ["text"], description: "City of the school", name: "city" },
        { dataType: ["text"], description: "Longitude of the school", name: "longitude" },
        { dataType: ["text"], description: "Latitude of the school", name: "latitude" },
        { dataType: ["number"], description: "Average humidity", name: "humidity_avg" },
        { dataType: ["number"], description: "Average pressure", name: "pressure_avg" },
        { dataType: ["number"], description: "Average temperature", name: "temperature_avg" },
        { dataType: ["number"], description: "Average PM10", name: "pm10_avg" },
        { dataType: ["number"], description: "Average PM2.5", name: "pm25_avg" },
        { dataType: ["text"], description: "Timestamp of the data", name: "timestamp" }
    ],
    vectorizer: "text2vec-openai"
)
