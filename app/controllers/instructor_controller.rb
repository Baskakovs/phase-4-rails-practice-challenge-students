class InstructorController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_instructor
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_entry_response

    def index
        instructors = Instructor.all
        render json: instructors
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor
    end

    def create
        instructor = Instructor.create!(name: params[:name])
        render json: instructor, status: :created
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(name: params[:name])
        render json: instructor, status: :accepted
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    private

    def render_not_found_instructor
        render json: { error: "Instructor not found" }, status: :not_found
    end

    def render_invalid_entry_response
        render json: { error: "Invalid entry" }, status: :unprocessable_entity
    end
end
