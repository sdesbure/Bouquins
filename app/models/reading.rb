class Reading < ActiveRecord::Base
  belongs_to :read_edition, :class_name => "Edition"
  belongs_to :reader, :class_name => "User"
end
