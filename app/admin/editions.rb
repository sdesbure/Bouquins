ActiveAdmin.register Edition do
  index do
    column "Image" do |edition|
      image_tag edition.image_url
    end
    column :book do |edition|
      edition.book.title
    end
    column :editor do |edition|
      edition.editor.name
    end
    column :isbn13
    column :price, :sortable => :price do |edition|
      case edition.currency
      when "EUR"
        number_to_currency edition.price, :unit => "&euro;"
      else
        edition.price
      end
    end
    default_actions
  end
  
end
