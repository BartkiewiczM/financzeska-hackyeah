class AddWeaviateIdToFaq < ActiveRecord::Migration[7.0]
  def change
    add_column :faqs, :weaviate_id, :string
    add_index :faqs, :weaviate_id, unique: true
  end
end
