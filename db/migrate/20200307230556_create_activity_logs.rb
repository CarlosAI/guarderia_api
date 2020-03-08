class CreateActivityLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_logs do |t|
      t.integer :baby_id
      t.integer :assistant_id
      t.integer :activity_id
      t.date :start_time
      t.date :stop_time
      t.integer :duration
      t.text :comments

      t.timestamps
    end
  end
end
