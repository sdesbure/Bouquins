class Editor  < ActiveRecord::Base

  has_many :editions
  has_many :books, :through => :editions
end
