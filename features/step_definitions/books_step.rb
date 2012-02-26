Given /^I've read the book "([^"]*)"$/ do |book_name|
  book = Book.where(:title => book_name).first
  book.should_not be nil
  edition = book.editions.count < 1 ? Edition.create(:book => book) : book.editions.first 
  user = User.first
  reading = Reading.new(:reader => user, :read_edition => edition, :end_read => DateTime.now() - 1.day)
  reading.save.should be_true
  user.read_editions(true).should_not be_empty
end


Given /^I've read the following books:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |row|
    step "I've read the book \"#{row["title"]}\""
  end
end

Given /^I've not read the book "([^"]*)"$/ do |arg1|
end

Given /^I own the book "([^"]*)"$/ do |book_name|
  book = Book.where(:title => book_name).first
  book.should_not be nil
  edition = book.editions.count < 1 ? Edition.create(:book => book) : book.editions.first 
  user = User.first
  owning = Owning.new(:owner => user, :owned_edition => edition)
  owning.save.should be_true
end

Given /^I don't own the book "([^"]*)"$/ do |arg1|
end

Given /^I own the following books:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |row|
    step "I own the book \"#{row["title"]}\""
  end
end

Given /^I've rated "([^"]*)" the book "([^"]*)"$/ do |rate, book_name|
  book = Book.where(:title => book_name).first
  book.should_not be nil
  book.rate(rate.to_i,User.first,nil)
end

Given /^I've not rated "([^"]*)" the book "([^"]*)"$/ do |rate, book_name|
end


Given /^the average rate of the book "([^"]*)" is "([^"]*)"$/ do |book_name, rate|
  book = Book.where(:title => book_name).first
  book.should_not be nil
  users = []
  20.times do |i|
    users[i] = User.create :email => "email#{i}@mail.com", :password => "s3cretPass", :password_confirmation => "s3cretPass"
    book.rate(rate.to_i,users[i],nil)
  end
end

Given /^I some other guy own the book "([^"]*)"$/ do |book_name|
  user = User.create :email => "emaile@mail.com", :password => "s3cretPass", :password_confirmation => "s3cretPass"
  book = Book.where(:title => book_name).first
  book.should_not be nil
  edition = book.editions.count < 1 ? Edition.create(:book => book) : book.editions.first
  owning = Owning.new(:owner => user, :owned_edition => edition)
  owning.save.should be_true
end

Given /^I've read and own the book "([^"]*)"$/ do |book|
  step "I've read the book \"#{book}\""
  step "I own the book \"#{book}\""
end


