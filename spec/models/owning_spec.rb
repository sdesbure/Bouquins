require 'spec_helper'

describe Owning do
  it { should have_db_column(:owned_edition_id).of_type(:integer) }
  it { should have_db_column(:owner_id).of_type(:integer) }

  it { should belong_to(:owner).class_name("User") }
  it { should belong_to(:owned_edition).class_name("Edition") }

  it "should retrieve owned_editions of an user" do
    user = Factory.build(:user)
    user.save!
    books = []
    editions = []
    10.times do |n|
      books << Factory(:book, :title => "book #{n}"  )
      editions << Factory(:edition, :book => books[n])
    end
    5.times do |n|
      Owning.create :owner => user,
        :owned_edition => editions[n]
    end
    user.save!
    user.owned_editions.count.should == 5
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
       Owning.create :owner => users[n],
         :owned_edition => edition
    end
    edition.owners.count.should == 5
  end
end
