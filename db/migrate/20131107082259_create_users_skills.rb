class CreateUsersSkills < ActiveRecord::Migration
  def change
    create_table :users_skills do |t|
      t.integer :user_id
      t.integer :skill_id
      t.integer :years_experience
      t.boolean :formally_educated

      t.timestamps
    end
  end
end
