class Owning < ActiveRecord::Base
  after_create :increment_book_counter
  after_destroy :decrement_book_counter
  belongs_to :owned_edition, :class_name => "Edition", :counter_cache => true
  belongs_to :owner, :class_name => "User", :counter_cache => true

  private
    def increment_book_counter
      self.owned_edition.book.owned_count += 1
      self.owned_edition.book.save!
    end

    def decrement_book_counter
      self.owned_edition.book.owned_count -= 1
      self.owned_edition.book.save!
    end
end
