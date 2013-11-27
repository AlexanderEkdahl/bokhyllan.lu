class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :programs, array: true, default: []
      t.string :code
    end

    add_index :courses, :code, unique: true
  end
end
