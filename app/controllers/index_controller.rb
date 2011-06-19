class IndexController < ApplicationController
  def index
    editions = Edition
    @most_read_books
    @most_owned_books
    @most_read_authors
    @most_owned_authors
    @most_read_editors
    @most_owned_editors
  end

end
