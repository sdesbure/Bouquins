ActiveAdmin.register Author do
  index do
    column :name
    column :nickname
    column :wikipedia_url
    column :image_url
    default_actions
  end

  show do
    attributes_table *default_attribute_table_rows
#    default_main_content
    div :class => "panel" do
      h3 "Author's books"
      div :class => "panel_contents" do
        table_for(author.books, {:class => "index_table"}) do
          column :title
          column :description
          column :wikipedia_url
          column :rating_average
          column "" do |book|
            link_to(I18n.t('active_admin.view'), admin_book_path(book), :class => "member_link view_link")
          end
        end
      end
    end
  end

end
