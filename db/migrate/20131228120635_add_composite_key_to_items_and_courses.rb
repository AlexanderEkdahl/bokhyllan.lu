class AddCompositeKeyToItemsAndCourses < ActiveRecord::Migration
  def up
    # remove duplicate entries
    execute "DELETE FROM courses_items c WHERE EXISTS ( SELECT 1 FROM courses_items c1 WHERE c1.ctid < c.ctid AND c.course_id = c1.course_id AND c.item_id = c1.item_id);"
    remove_index :courses_items, [:course_id, :item_id]
    remove_index :courses_items, [:item_id, :course_id]
    add_index(:courses_items, [:item_id, :course_id], unique: true)
  end

  def down
    remove_index :courses_items, [:item_id, :course_id]
    add_index :courses_items, [:course_id, :item_id]
    add_index :courses_items, [:item_id, :course_id]
  end
end
