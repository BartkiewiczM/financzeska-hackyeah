require 'weaviate'

client = Weaviate::Client.new(
    url: 'https://financzeska-d5vrxbo2.weaviate.network',  # Replace with your endpoint
    api_key: Rails.application.credentials.weaviate_api_key,
    model_service: :openai, # Service that will be used to generate vectors. Possible values: :openai, :azure_openai, :cohere, :huggingface, :google_palm
    model_service_api_key: Rails.application.credentials.open_ai_api_key # API key for the model service
)

client.schema.create(
    class_name: 'Faq',
    description: 'Frequently asked questions',
    properties: [
        { dataType: ["text"], description: "Content of the FAQ", name: "content" }
    ],
    vectorizer: "text2vec-openai"
)
