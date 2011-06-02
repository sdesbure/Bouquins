class Edition  < ActiveRecord::Base

  belongs_to :book
  belongs_to :editor
end
