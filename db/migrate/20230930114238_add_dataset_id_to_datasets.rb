class AddDatasetIdToDatasets < ActiveRecord::Migration[7.0]
  def change
    add_column :datasets, :dataset_id, :string
  end
end
