class Reading < ActiveRecord::Base
  after_create :increment_book_counter
  after_destroy :decrement_book_counter
  belongs_to :read_edition, :class_name => "Edition", :counter_cache => true
  belongs_to :reader, :class_name => "User", :counter_cache => true

  private
    def increment_book_counter
      self.read_edition.book.read_count += 1
      self.read_edition.book.save!
    end

    def decrement_book_counter
      self.read_edition.book.read_count -= 1
      self.read_edition.book.save!
    end
end
