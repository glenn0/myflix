class CreateReviews < ActiveRecord::Migration
  def up
    create_table :reviews do |t|
      t.integer :rating
      t.text :review_text
      t.timestamps
    end
  end

  def down
    drop_table :reviews
  end
end