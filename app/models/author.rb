class Author
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :first_name, String
  property :nickname, String
  property :wikipedia_url, URI
  property :image_url, URI
  property :created_at, DateTime
  # property :created_on, Date
  property :updated_at, DateTime
  # property :updated_on, Date

  has n, :books, :through => Resource

end
