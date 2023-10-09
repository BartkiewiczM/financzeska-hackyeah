class FaqService
  WEAVIATE_BASE_URL = 'https://financzeska-d5vrxbo2.weaviate.network' unless defined?(WEAVIATE_BASE_URL)

  def self.create(content)
    faq = Faq.create(content: content)
    client = initialize_client

    response = client.objects.create(
      class_name: 'Faq',
      properties: {
        content: content
      }
    )
    pp "response = " + response["id"]

    weaviate_id = response["id"]

    faq = Faq.create(content: content, weaviate_id: weaviate_id)

    faq
  end

  def self.delete(faq)
    client = initialize_client
    client.objects.delete(
      class_name: "Faq",
      id: faq.weaviate_id
    )

    faq.destroy
  end

  private

  def self.initialize_client
    Weaviate::Client.new(
      url: WEAVIATE_BASE_URL,
      api_key: Rails.application.credentials.weaviate_api_key,
      model_service: :openai,
      model_service_api_key: Rails.application.credentials.open_ai_api_key
    )
  end
end
