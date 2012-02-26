ActiveAdmin.register Book do
  index do
    column :title
    column :description
    column :rating_average
    column :wikipedia_url
    default_actions
  end
  
  show do
    attributes_table *default_attribute_table_rows
    div :class => "panel" do
      h3 "Book's authors"
      div :class => "panel_contents" do
        table_for(book.authors, {:class => "index_table"}) do
          column :name do |author|
            link_to author.name,  admin_author_path(author), :class => "member_link view_link"
          end
          column :nickname
          column :wikipedia_url
          column :image_url
        end
      end
    end

    unless book.readers.empty?
      div :class => "panel" do
        h3 "Book's readers"
        div :class => "panel_contents" do
          table_for(book.readers, {:class => "index_table"}) do
            column :email do |user|
              link_to user.email, admin_user_path(user)
            end
            column I18n.t(:edition) do |user|
              link_to user.edition(book).isbn13, admin_edition_path(user.edition(book)), :class => "member_link view_link" unless user.edition(book).nil?
            end
            column I18n.t(:rate) do |user|
              book.rate_by(user)
            end
          end
        end
      end
    end

    unless book.owners.empty?
      div :class => "panel" do
        h3 "Book's owners"
        div :class => "panel_contents" do
          table_for(book.owners, {:class => "index_table"}) do
            column :email
            column I18n.t(:edition) do |user|
              link_to user.edition(book).isbn13, admin_edition_path(user.edition(book)), :class => "member_link view_link" unless user.edition(book).nil?
            end
            column I18n.t(:rate) do |user|
              book.rate_by(user)
            end
          end
        end
      end
    end

    div :class => "panel" do
      h3 "Book's editions"
      div :class => "panel_contents" do
        table_for(book.editions, {:class => "index_table"}) do
          column :isbn13 do |edition|
            link_to edition.isbn13, admin_edition_path(edition), :class => "member_link view_link"
          end
          column :editor do |edition|
            link_to edition.editor.name, admin_editor_path(edition.editor), :class => "member_link view_link" unless edition.editor.nil?
          end
          column :image_url do |edition|
            image_tag edition.image_url
          end
          column :year
          column :price do |edition|
            case edition.currency
            when "EUR"
              number_to_currency edition.price, :unit => "&euro;"
            else
              edition.price
            end
          end
        end
      end
    end

    div :class => "panel" do
      h3 "Book's editors"
      div :class => "panel_contents" do
        table_for(book.editors, {:class => "index_table"}) do
          column :name do |editor|
            link_to editor.name, admin_editor_path(editor),  :class => "member_link view_link"
          end
          column :logo do |editor|
            image_tag editor.logo unless editor.logo.nil?
          end
          column :wikipedia_url do |editor|
            link_to(I18n.t('wikipedia_url'), editor.wikipedia_url) unless editor.wikipedia_url.nil?
          end
          column :website do |editor|
            link_to(I18n.t('website'), editor.website) unless editor.website.nil?
          end
        end
      end
    end  
  end
end
