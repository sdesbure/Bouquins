Given /^I've read the book "([^"]*)"$/ do |book_name|
  book = Book.where(:title => book_name).first
  book.should_not be nil
  user = User.first
  reading = Reading.new(:reader => user, :read_book => book, :end_read => DateTime.now() - 1.day)
  reading.save.should be_true
end


Given /^I've read the following books:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |row|
    Given "I've read the book \"#{row["title"]}\""
  end
end


