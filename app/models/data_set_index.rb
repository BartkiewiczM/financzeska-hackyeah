class DataSetIndex < ActivePinecone::Base
  vectorizes :title, :notes
end
