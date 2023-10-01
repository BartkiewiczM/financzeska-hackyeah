class OpenaiService
  def self.generate_response(prompt)
    client = Openai::Client.new(api_key: Rails.application.credentials.open_ai_api_key)
    response = client.completions.create(
      model: "gpt-4.0-turbo",
      prompt: prompt,
      max_tokens: 150
    )
    response.choices.first.text.strip
  end
end
