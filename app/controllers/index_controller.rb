class IndexController < ApplicationController
  def index
    @most_read_books = Book.order("read_count DESC").limit(5)
    @most_owned_books = Book.order("owned_count DESC").limit(5)
  end

end
