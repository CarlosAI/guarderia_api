class ApiController < ApplicationController

	before_action :validado, :only => [:activity_logs, :update_activity, :all_activity_logs]

	def validado
		puts params
		puts request.headers["Auth-Token"]
	    puts request.headers["User"]
	    if request.headers["Auth-Token"].present? && request.headers["User"].present?
	    	token = request.headers["Auth-Token"]
      		user = request.headers["User"]
      		usuario = User.where("token"=>token, "nombre"=>user).take
      		if usuario.nil?
      			render status: 402, json: { message: "Usuario y/o Token Invalido",}.to_json
      		end
	    else
	    	render status: 400, json: { message: "Auth-Token y User son obligatorios",}.to_json
	    end 
	end

	def activities
		@actividades = Activity.all
		pagina = 1
		if params[:page].present?
			pagina = params[:page]
		end
		@actividades = @actividades.paginate(:page => pagina, :per_page =>10)
		render json: @actividades
	end

	def assistants
		@assistants = Assistant.select("id, name").order(name: :asc)
		render json: @assistants
	end

	def babies
		@bebes = Baby.select("age (current_date, birthday), id, name, mother_name, father_name, address, phone").order(name: :asc)
		render json: @bebes
	end

	def show_baby
		@bebe = Baby.find_by_id(params[:id])
		render json: @bebe
	end

	def activity_log
		@actividad_bebe = ActivityLog.where("baby_id"=> params[:id]).select("id, baby_id, (select name from assistants where id=activity_logs.assistant_id) as assistant_name, start_time, stop_time, (CASE WHEN stop_time is null then 'En progreso' else 'Terminada' end) as status")
		pagina = 1
		if params[:page].present?
			pagina = params[:page]
		end
		@actividad_bebe = @actividad_bebe.paginate(:page => pagina, :per_page =>10)
		render json: @actividad_bebe
	end

	def activity_logs
		crear = ActivityLog.crear_activity_log(params)
		render status: crear[0], json: { message: crear[1],}.to_json
	end

	def update_activity
		actualizar = ActivityLog.update_activity_log(params)
		render status: actualizar[0], json: { message: actualizar[1],}.to_json
	end

	def all_activity_logs
		@actividades = ActivityLog.all.select("id, baby_id, assistant_id, duration, start_time, (select name from babies where id=activity_logs.baby_id) as baby_name, (select name from assistants where id=activity_logs.assistant_id) as assistant_name, (select name from activities where id=activity_logs.activity_id) as activity_name, (CASE WHEN stop_time is null then 'En progreso' else 'Terminada' end) as status").order(id: :desc)
		@actividades = @actividades.where("baby_id"=>params[:baby_id])if params[:baby_id].present?
		@actividades = @actividades.where("assistant_id"=>params[:assistant_id])if params[:assistant_id].present?
		if params["status"].present?
			if params["status"] == "Terminada"
				@actividades = @actividades.where("duration is not null")
			elsif params["status"] == "En progreso"
				@actividades = @actividades.where("duration is null")	
			end
		end
		pagina = 1
		if params[:page].present?
			pagina = params[:page]
		end
		@actividades = @actividades.paginate(:page => pagina, :per_page =>10)
		render json: @actividades
	end
end
