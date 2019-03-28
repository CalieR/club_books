class AddImageUrlToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :image_url, :string, default: "https://www.fillmurray.com/640/360"
  end
end
