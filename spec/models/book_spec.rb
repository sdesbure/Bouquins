require 'spec_helper'

describe Book do
  it { should have_db_column(:id).of_type(:integer) }
  it { should have_db_column(:title).of_type(:string) }
  it { should have_db_column(:description).of_type(:text) }
  it { should have_db_column(:wikipedia_url).of_type(:string) }
  it { should have_db_column(:editions_count).of_type(:integer) }

  it { should have_and_belong_to_many :authors }
  it { should have_many :editions }
  it { should have_many(:editors).through(:editions) }

  describe "#owners" do
    it "should give [] when there's no editions" do
       book = Factory(:book)
       book.editions = []
       book.owners.should == []
    end

    it "should give [] when there's no owners of its editions" do
      book = Factory(:book)
      edition1 = Factory(:edition, :book => book)
      edition2 = Factory(:edition, :book => book)
      edition1.owners = []
      edition2.owners = []
      book.owners.should == []
    end

    it "should give only the users owning one edition of the book" do
      book = Factory(:book)
      book2 = Factory(:book)
      edition1 = Factory(:edition, :book => book)
      edition2 = Factory(:edition, :book => book)
      edition3 = Factory(:edition, :book => book2)
      user1 = Factory(:user, :email => "user1@mail.com")
      user2 = Factory(:user, :email => "user2@mail.com")
      user3 = Factory(:user, :email => "user3@mail.com")
      user4 = Factory(:user, :email => "user4@mail.com")
      owning1 = Factory(:owning, :owner => user1, :owned_edition => edition1)
      owning2 = Factory(:owning, :owner => user2, :owned_edition => edition2)
      owning3 = Factory(:owning, :owner => user3, :owned_edition => edition2)
      owning4 = Factory(:owning, :owner => user4, :owned_edition => edition3)
      book.owners.should =~ [user1,user3,user2]
    end
  end

  describe "#readers" do
    it "should give [] when there's no editions" do
       book = Factory(:book)
       book.editions = []
       book.readers.should == []
    end

    it "should give [] when there's no owners of its editions" do
      book = Factory(:book)
      edition1 = Factory(:edition, :book => book)
      edition2 = Factory(:edition, :book => book)
      edition1.readers = []
      edition2.readers = []
      book.readers.should == []
    end

    it "should give only the users owning one edition of the book" do
      book = Factory(:book)
      book2 = Factory(:book)
      edition1 = Factory(:edition, :book => book)
      edition2 = Factory(:edition, :book => book)
      edition3 = Factory(:edition, :book => book2)
      user1 = Factory(:user, :email => "user1@mail.com")
      user2 = Factory(:user, :email => "user2@mail.com")
      user3 = Factory(:user, :email => "user3@mail.com")
      user4 = Factory(:user, :email => "user4@mail.com")
      reading1 = Factory(:reading, :reader => user1, :read_edition => edition1)
      reading2 = Factory(:reading, :reader => user2, :read_edition => edition2)
      reading3 = Factory(:reading, :reader => user3, :read_edition => edition2)
      reading4 = Factory(:reading, :reader => user4, :read_edition => edition3)
      book.readers.should =~ [user1,user3,user2]
    end
  end

  describe "#author" do
    it "should give the author first_name and name if the author has no nickname" do
      author = Factory(:author, :name => "Jo Nesbo")
      book = Factory(:book, :authors => [author])
      book.author.should == "Jo Nesbo"
    end

    it "should give the authors nickname or first_name and name for all the authors" do
      author = Factory(:author, :name => "Jack London")
      author2 = Factory(:author, :name => "Jo Nesbo")
      book = Factory(:book, :authors => [author, author2])
      book.author.should match "(Jo Nesbo, Jack London|Jack London, Jo Nesbo)"
    end

    it "should give '' if there's no authors for the book" do
      book = Factory(:book)
      book.author.should == ""
    end
  end

  describe "#search" do
    it "should reply [] if the query is nil or empty" do
      Book.search(nil).should == []
      Book.search("").should == []
    end

    describe "without using Amazon" do
      before :each do
        Amazon::Ecs.configure do |options|
          options[:AWS_access_key_id] = ""
          options[:AWS_secret_key] = ""
          book = Factory :book
          @edition = Factory :edition, :book => book
        end
      end

      it { Book.search(@edition.isbn10).should == [@edition] }

      it { Book.search(@edition.isbn13).should == [@edition] }
    end

    describe "with Amazon search" do
      before :all do
        require "#{Rails.root}/config/initializers/amazon"
      end
      describe "when search is on ISBN 2092531549" do
        before :all do
          @search = Book.search("2092531549")
        end

        after :all do
          Edition.delete_all
          Author.delete_all
          Book.delete_all
          Editor.delete_all
        end

        subject {@search }

        it { @search.should == [Edition.where(:isbn10 =>  "2092531549").first ] }
        it { @search[0].isbn10.should == "2092531549" }
        it { @search[0].isbn13.should == "9782092531549" }
        it { @search[0].image_url.should match "http://ecx.images-amazon.com/images/I/[^']*._SL75_.jpg" }
        it { @search[0].book.title.should == "T'choupi aime sa nounou" }
        it { @search[0].book.authors[0].name.should == "Thierry Courtin" }
        it { @search[0].amazon_url.should match "http://[^']" }
        it { @search[0].price.should be_kind_of(BigDecimal) }
        it { @search[0].price.should >= 0 }
        it { @search[0].currency.should == "EUR" }
      end

      describe "when search is on ISBN 9782092531549" do
        before :all do
          @search = Book.search("9782092531549")
        end

        after :all do
          Edition.delete_all
          Author.delete_all
          Book.delete_all
          Editor.delete_all
        end

        subject {@search }

        it { @search.should == [Edition.first] }
        it { @search[0].isbn10.should == "2092531549" }
        it { @search[0].isbn13.should == "9782092531549" }
        it { @search[0].image_url.should match "http://ecx.images-amazon.com/images/[^']*._SL75_.jpg" }
        it { @search[0].book.title.should == "T'choupi aime sa nounou" }
        it { @search[0].book.authors[0].name.should == "Thierry Courtin" }
        it { @search[0].price.should be_kind_of(BigDecimal) }
        it { @search[0].price.should >= 0 }
        it { @search[0].currency.should == "EUR" }
      end

      describe "when search is not isbn" do
        @search = []
        before :all do
          @search =  Book.search("Christian Jacq")
        end

        after :all do
          Edition.delete_all
          Author.delete_all
          Book.delete_all
          Editor.delete_all
        end

        subject {@search }

        it { @search.should be_an(Array) }
        it { @search.count.should == 10 }
        @search.each do |item|
          it { item.should be_an(Edition) }
          it { item.isbn10.should_not be_nil }
          it { item.isbn13.should_not be_nil }
          it { item.image_url.should_not be_nil }
          it { item.book.should_not be_nil }
          it { item.book.title.should_not be_nil }
          it { item.book.authors.should_not be_nil }
          it { item.amazon_url.should_not be_nil }
          it { item.price.should_not be_nil }
          it { item.currency.should == "EUR" }
          item.book.authors.each{|a| it { a.name.should_not be_nil } }
        end
      end

      describe "when search returns nothing" do
        it {Book.search("57742etagrorlkfjkfjlgkjsdf").should == []}
      end
    end
  end
end
