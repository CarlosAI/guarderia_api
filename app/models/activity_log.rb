class ActivityLog < ApplicationRecord
	belongs_to :baby
	belongs_to :activity
	belongs_to :assistant

	before_update :set_duration

	def set_duration
		duration = ((stop_time - start_time) / 1.hour)*60
		self.duration = duration.ceil
	end


	def self.crear_activity_log(params)
		if params[:baby_id].present? && params[:activity_id].present? && params[:assistant_id].present? && params[:start_time].present?
			baby = Baby.find_by_id(params[:baby_id])
			if baby.present?
				actividad = Activity.find_by_id(params[:activity_id])
				if actividad.present?
					teach = Assistant.find_by_id(params[:assistant_id])
					if teach.present?
						valid_date = true
						begin
							DateTime.parse(params[:start_time])
						rescue ArgumentError
							puts "Fecha invalida"
							valid_date = false
						end
						if valid_date
							d = ActivityLog.new
							d.baby_id = params[:baby_id]
							d.assistant_id = params[:assistant_id]
							d.activity_id = params[:activity_id]
							Time.zone = "Mexico City"
							d.start_time = DateTime.parse(params[:start_time]).in_time_zone
							if d.save
								[200, "SUCCESS"]
							else
								[404, "Something Wrong Happend, #{d.errors.messages}"]
							end
						else
							[400, "Invalid Date Format"]
						end
					else
						return [400, "Assistant must exists"]
					end
				else
					return [400, "Activity must exists"]
				end
			else
				return [400, "Baby must exists"]
			end
		else
			return [400, "Parametros incompletos, Obligatorios (baby_id, activity_id, assistant_id, start_time)"]
		end
	end

	def self.update_activity_log(params)
		Time.zone = "Mexico City"
		if params[:stop_time].present? && params[:id].present?
			activity_log = ActivityLog.find_by_id(params[:id])
			if activity_log.present?
				valid_date = true
				begin
					DateTime.parse(params[:stop_time])
				rescue ArgumentError
					puts "Fecha invalida"
					valid_date = false
				end
				if valid_date
					activity_log.stop_time = DateTime.parse(params[:stop_time]).in_time_zone
					if activity_log.save
						[200, "SUCCESS"]
					else
						[404, "Something Wrong Happend, #{d.errors.messages}"]
					end
				else
					[400, "Invalid Date Format"]
				end
			else
				[400, "ActivityLog not found"]
			end
		else
			return [400, "Parametros incompletos, Obligatorios (stop_time, id)"]
		end
	end
end
