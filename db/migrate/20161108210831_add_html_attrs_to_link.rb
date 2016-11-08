class AddHtmlAttrsToLink < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :html_h1, :text
    add_column :links, :html_title, :text
  end
end
