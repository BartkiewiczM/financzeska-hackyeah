class CreateInstitutions < ActiveRecord::Migration[7.0]
  def change
    create_table :institutions do |t|
      t.string :slug
      t.string :tel
      t.text :notes
      t.string :postal_code
      t.string :abbreviation
      t.string :email
      t.string :regon
      t.string :flat_number
      t.string :city
      t.string :institution_type
      t.string :title
      t.string :image_url
      t.string :street
      t.string :street_type
      t.text :description
      t.string :website
      t.string :street_number
      t.datetime :modified
      t.datetime :created
      t.string :epuap
      t.string :fax
      t.boolean :followed

      t.timestamps
    end
  end
end
