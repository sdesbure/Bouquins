class Book  < ActiveRecord::Base


  has_and_belongs_to_many :authors
  has_and_belongs_to_many :users
  has_many :readings, :foreign_key => "read_book_id"
  has_many :editions
  has_many :editors, :through => :editions
  has_many :readers, :through => :readings, :class_name => "User"

  def author
     unless authors.empty?
       authors.map{|author| author.nickname.nil? ? "#{author.first_name} #{author.name}" : author.nickname}.join(", ")
     else
       ""
     end
   end

end
