# app/models/faq.rb
class Faq < ApplicationRecord
  validates :content, presence: true
  # Assuming you added a column `weaviate_id` to store the Weaviate object ID
  validates :weaviate_id, presence: true, uniqueness: true
end
