class Book  < ActiveRecord::Base


  has_and_belongs_to_many :authors
  has_many :editions
  has_many :editors, :through => :editions

end
