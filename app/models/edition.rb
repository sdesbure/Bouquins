class Edition
  include DataMapper::Resource

  property :id, Serial
  property :isbn, String
  property :image_url, URI
  property :year, Date
  property :created_at, DateTime
  # property :created_on, Date
  property :updated_at, DateTime
  # property :updated_on, Date

  belongs_to :book
end
