class Editor
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :website, URI
  property :logo, URI
  property :wikipedia_url, URI
  property :created_at, DateTime
  # property :created_on, Date
  property :updated_at, DateTime
  # property :updated_on, Date

  has n, :editions
  has n, :books, :through => :editions
end
