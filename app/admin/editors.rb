ActiveAdmin.register Editor do
  index do
    column :name
    column "Website" do |editor|
      link_to editor.website unless editor.website.nil?
    end
    column "Logo" do |editor|
      image_tag editor.logo, {:alt => "#{editor.name} logo", :size =>"40x40"}  unless editor.logo.nil?
    end
    column "Wikipedia Url" do |editor|
      link_to editor.wikipedia_url unless editor.wikipedia_url.nil?
    end
    default_actions
  end
   
  show do
    attributes_table *default_attribute_table_rows
    div :class => "panel" do
      h3 "Editor's books"
      div :class => "panel_contents" do
        table_for(editor.editions, {:class => "index_table"}) do
          column "Title" do |e| 
            e.book.title
          end
          column "front" do |e|
            image_tag e.image_url
          end
          column :isbn13
          column :year
          column "Description" do |e| 
            e.book.description
          end
          column "Wikipedia_url" do |e| 
            link_to e.book.wikipedia_url unless e.book.wikipedia_url.nil?
          end
          column "Rating_average" do |e| 
            e.book.rating_average
          end
          column "amazon_url" do |e|
            link_to e.amazon_url unless e.amazon_url.nil?
          end
          column :price
          column :currency
          column "" do |e|
            link_to(I18n.t('active_admin.view'), admin_book_path(e.book), :class => "member_link view_link")
          end
        end
      end
    end
  end
end
