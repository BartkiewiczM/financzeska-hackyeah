class ContentWriter
  MODEL = 'gpt-3.5-turbo'

  def self.write_draft_post(title, chat_history = [], database_response = nil)
    client = OpenAI::Client.new
    base_prompt = "This was the message from chatbot user. Your response will be a response according to chat's history.
    You are a chatbot that provides info about Lunar Logic company.
    In this message the backend of the app also will give you some data from a vector database with info about the company, so after this you'll get
    content from the database and you'll have to use it in your response if it fits.
    Procide only information about the question asked. Please make the responses short and keep the conversation going.
    Please don't provide any info that you are not sure about.
    Here is the info from the database: #{database_response}"

    messages = [
      {
        role: "user",
        content: " #{database_response}"
      }
    ]
    pp "database_response " + database_response.to_s

    messages = chat_history.map do |message|
      {
        role: message.from_user ? "user" : "assistant",
        content: message.content
      }
    end

    messages << { role: "user", content: title + base_prompt }

    response = client.chat(
      parameters: {
        model: MODEL,
        messages: messages
      }
    )

    response["choices"].first["message"]["content"].strip
  end
end
