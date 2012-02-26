class Book  < ActiveRecord::Base
  ajaxful_rateable :stars => 5

  has_and_belongs_to_many :authors
  has_many :editions
  has_many :editors, :through => :editions

  def owners
    owners = []
    editions.each {|e| owners += e.owners}
    owners.uniq{|o| o.id}
  end

  def readers
    readers = []
    editions.each {|e| readers += e.readers}
    readers.uniq{|r| r.id}
  end

  def author
    unless authors.empty?
      authors.map{|author| author.name}.join(", ")
    else
      ""
    end
  end

  def self.search(query)
    Rails.logger.debug "Searching query #{query}"
    unless query.nil? || query == ""
      is_isbn = false
      if StdNum::ISBN.valid?(query)
        is_isbn = true
        edition = Edition.where(:isbn13 =>  StdNum::ISBN.convert_to_13(query)).first
        return [edition] unless edition.nil?
      end
      query = is_isbn ?  StdNum::ISBN.convert_to_13(query) : query
      res = Amazon::Ecs.item_search( query,
                                    { :country => 'fr', :response_group => "Medium"})
      Rails.logger.debug "Result for the query: "
      Rails.logger.debug res.to_s
      if res.total_results >= 1
        result = []
        res.items.each do |item|
          item_attributes = item.get_element "ItemAttributes"
          unless item_attributes.get("ProductGroup") != "Book"
            edition = Edition.where(:isbn13 =>  StdNum::ISBN.convert_to_13( item_attributes.get("EAN"))).first
            if edition.nil?
              edition = Edition.where(:isbn10 =>  StdNum::ISBN.convert_to_10( item_attributes.get("ISBN"))).first unless  item_attributes.get("ISBN").nil?
              if edition.nil?
                book = Book.find_or_create_by_title(Book.get(item_attributes,"Title"))
                authors = Book.get_array(item_attributes,("Author"))
                unless authors.nil?
                  authors.each do |author|
                    known_author = Author.find_or_create_by_name(:name => author)
                    book.authors << known_author unless book.authors.include?(known_author)
                    book.save!
                  end
                end
                editor = Editor.find_or_create_by_name(Book.get(item_attributes,("Label")))
                unless item_attributes.get("PublicationDate").nil?
                  date = case item_attributes.get("PublicationDate").split("-").size
                         when 1 
                           DateTime.civil(item_attributes.get("PublicationDate").to_i)
                         when 2 
                           DateTime.civil(item_attributes.get("PublicationDate").split("-")[0].to_i,
                                          item_attributes.get("PublicationDate").split("-")[1].to_i)
                         when 3 
                           DateTime.civil(item_attributes.get("PublicationDate").split("-")[0].to_i,
                                          item_attributes.get("PublicationDate").split("-")[1].to_i,
                                          item_attributes.get("PublicationDate").split("-")[2].to_i)
                         else 
                           nil
                         end
                end
                image = item.get_hash("SmallImage")["URL"] unless item.get_hash("SmallImage").nil?
                url = item.get "DetailPageURL"
                price = item_attributes.get_hash("ListPrice")["Amount"].to_i / 100.0 unless item_attributes.get_hash("ListPrice").nil?
                currency = item_attributes.get_hash("ListPrice")["CurrencyCode"] unless item_attributes.get_hash("ListPrice").nil?
                edition = Edition.create(:book => book,
                                         :editor => editor,
                                         :isbn10 => item_attributes.get("ISBN").nil? ? nil : StdNum::ISBN.convert_to_10( item_attributes.get("ISBN")) ,
                                         :isbn13 => StdNum::ISBN.convert_to_13( item_attributes.get("EAN")),
                                         :image_url =>  image,
                                         :year => date,
                                         :amazon_url => url,
                                         :currency => currency,
                                         :price => price)
              end
            end
            result << edition
          end
        end
        Rails.logger.debug "End searching query #{query}: #{result.count} items found"
        return result
      else
        Rails.logger.debug "End searching query #{query}: result is emptyi (result given by Amazon is empty)"
        return []
      end
    else
     Rails.logger.debug "End searching query #{query}: result is empty (query was empty or nil)"
      return []
    end
    Rails.logger.debug "End searching query #{query}: we shouldn't end here..."
  end

  private
  def self.get(attribute,element)
    (attribute./element).first.children.first.content unless (attribute./element).nil?
  end

  def self.get_array(attribute,element)
    (attribute./element).map{|el| el.children.first.content} unless (attribute./element).nil?
  end
end
