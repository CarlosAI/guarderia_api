class ApiController < ApplicationController
	#curl http://localhost:3000/api/activities -X GET -H "Content-type: application/json"
	def activities
		@actividades = Activity.all
		render status: 400, json: @actividades
	end

	def babies
		@bebes = Baby.all
		render json: @bebes
	end

	def show_baby
		@bebe = Baby.find_by_id(params[:id])
		render json: @bebe
	end

	def activity_log
		@actividad_bebe = ActivityLog.where("baby_id"=> params[:id])
		pagina = 1
		if params[:page].present?
			pagina = params[:page]
		end
		@actividad_bebe = @actividad_bebe.paginate(:page => pagina, :per_page =>10)
		render json: @actividad_bebe
	end

	def activity_logs
	end

	def update_activity
	end
end
