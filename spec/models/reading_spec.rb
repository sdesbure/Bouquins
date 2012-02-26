require 'spec_helper'

describe Reading do
  it { should have_db_column(:read_edition_id).of_type(:integer) }
  it { should have_db_column(:reader_id).of_type(:integer) }
  it { should have_db_column(:start_read).of_type(:datetime) }
  it { should have_db_column(:end_read).of_type(:datetime) }

  it { should belong_to(:reader).class_name("User") }
  it { should belong_to(:read_edition).class_name("Edition") }

  it "should retrieve read_editions of an user" do
    user = Factory.build(:user)
    user.save!
    books = []
    editions = []
    10.times do |n|
      books << Factory(:book, :title => "book #{n}"  )
      editions << Factory(:edition, :book => books[n])
    end
    5.times do |n|
      Reading.create :reader => user,
        :read_edition => editions[n]
    end
    user.save!
    user.read_editions.count.should == 5
  end

  it "should retrieve users who have read this edition" do
    book = Factory(:book)
    edition = Factory :edition, :book => book
    users = []
    10.times do |n|
       Factory.build(:user,:email => "email#{n}@mail.com").save!
       users << User.last
    end
    5.times do |n|
       Reading.create :reader => users[n],
         :read_edition => edition
    end
    edition.readers.count.should == 5
  end
end
