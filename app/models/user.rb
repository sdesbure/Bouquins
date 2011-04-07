class User
  include DataMapper::Resource
  include DataMapper::MassAssignmentSecurity
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  property :id, Serial
  property :login, String
  property :created_at, DateTime
  # property :created_on, Date
  property :updated_at, DateTime
  # property :updated_on, Date
  #
  attr_accessible :email, :login, :password, :password_confirmation


end
