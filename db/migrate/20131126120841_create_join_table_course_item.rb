class CreateJoinTableCourseItem < ActiveRecord::Migration
  def change
    create_join_table :courses, :items do |t|
      t.index [:course_id, :item_id]
      t.index [:item_id, :course_id]
    end
  end
end
