class ScientistsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :not_found

rescue_from ActiveRecord::RecordInvalid, with: :invalid

    def index
        render json: Scientist.all, status: :ok 
    end 

    def show 
        scientist = Scientist.find(params[:id])
        render json: scientist, serializer: ShowscientistSerializer, status: :ok 
    end 

    def create
        s = Scientist.create!(s_params)
        render json: s, status: :created 
    end 

    def update 
        s = Scientist.find(params[:id])
        s.update!(s_params)
        render json: s, status: 202 
    end 

    def destroy 
        s = Scientist.find(params[:id])
        s.destroy!
        render json: {}, status: 204
    end 

    private 

    def s_params
        params.permit(:name, :field_of_study, :avatar)
    end 

    def not_found
        render json: {  "error": "Scientist not found"
        }, status: 404 
    end 

    def invalid(error)
        render json: {
            errors: error.record.errors.full_messages
        }, status: 422
    end 
    
end
