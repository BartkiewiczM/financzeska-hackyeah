class ContentWriter
  MODEL = 'gpt-3.5-turbo'

  def self.write_draft_post(title, chat_history = [], database_response = nil)
    client = OpenAI::Client.new

    messages = [
      {
        role: "user",
        content: "Uzyj prosze tych danych z mojej bazy danej, jeśli pasują do pytania, ale sformatuj je ładnie, nie musisz uyć wszystkich danych: #{database_response}"
      }
    ]
    pp "database_response " + database_response.to_s

    messages = chat_history.map do |message|
      {
        role: message.from_user ? "user" : "assistant",
        content: message.content
      }
    end

    messages << { role: "user", content: title + "Uzyj prosze tych danych na poczatku odpowiedzi chatu #{database_response}" }

    response = client.chat(
      parameters: {
        model: MODEL,
        messages: messages
      }
    )

    response["choices"].first["message"]["content"].strip
  end
end
