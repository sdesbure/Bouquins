ActiveAdmin.register User do
  index do
    column :email
    column :current_sign_in_at
    default_actions
  end

  show do
    attributes_table *default_attribute_table_rows

    unless user.read_editions.empty?
      div :class => "panel" do
        h3 "User's read books"
        div :class => "panel_contents" do
          table_for(user.read_editions, {:class => "index_table"}) do
            column "Title" do |e| 
              link_to e.book.title, admin_book_path(e.book), :class => "member_link view_link"
            end
            column "front" do |e|
              link_to(image_tag(e.image_url), admin_edition_path(e), :class => "member_link view_link")
            end
            column :isbn13 do |e|
              link_to e.isbn13, admin_edition_path(e), :class => "member_link view_link"
            end
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
          end
        end
      end
    end


    unless user.owned_editions.empty?
      div :class => "panel" do
        h3 "User's owned books"
        div :class => "panel_contents" do
          table_for(user.owned_editions, {:class => "index_table"}) do
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
end
