class User  < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  ajaxful_rater

  has_many :readings, :foreign_key => "reader_id"
  has_many :read_editions, :through => :readings, :class_name => "Edition"
  has_many :ownings, :foreign_key => "owner_id"
  has_many :owned_editions, :through => :ownings, :class_name => "Edition"

  def edition(book)
    editions = (read_editions + owned_editions).uniq{|e| e.id}
    editions.each do |edition|
      if edition.book.id == book.id
        return edition
      end
    end
    return nil
  end

end
