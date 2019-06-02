class RemoveImgToPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :img, :string
    remove_column :posts, :image_content, :string
  end
end
