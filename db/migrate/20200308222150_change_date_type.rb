class ChangeDateType < ActiveRecord::Migration[5.2]
  def change
  	change_column :activity_logs, :start_time, :datetime
  	change_column :activity_logs, :stop_time, :datetime
  end
end
