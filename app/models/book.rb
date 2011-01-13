class Book
  include DataMapper::Resource

  property :id, Serial

  property :created_at, DateTime
  # property :created_on, Date
  property :updated_at, DateTime
  # property :updated_on, Date

  has n, :authors, :through => Resource
  has n, :editions

end
