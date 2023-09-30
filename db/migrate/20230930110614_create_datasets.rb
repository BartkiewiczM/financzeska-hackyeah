class CreateDatasets < ActiveRecord::Migration[7.0]
  def change
    create_table :datasets do |t|
      t.references :institution, null: false, foreign_key: true
      t.string :slug
      t.integer :downloads_count
      t.text :notes
      t.text :license_condition_custom_description
      t.string :archived_resources_files_url
      t.string :url
      t.string :title
      t.string :image_url
      t.datetime :modified
      t.datetime :created
      t.boolean :followed

      t.timestamps
    end
  end
end
