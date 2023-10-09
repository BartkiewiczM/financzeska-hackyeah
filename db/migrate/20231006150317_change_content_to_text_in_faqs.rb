class ChangeContentToTextInFaqs < ActiveRecord::Migration[6.0]
  def change
    change_column :faqs, :content, :text
  end
end
