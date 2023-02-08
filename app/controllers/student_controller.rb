class StudentController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record_response
    def index
        students = Student.all
        render json: students
    end

    def show
        student = Student.find(params[:id])
        render json: student
    end

    def create
        student = Student.create!(name: params[:name], instructor_id: params[:instructor_id], age: params[:age], major: params[:major])
        render json: student, status: :created
    end

    def update
        student = Student.find(params[:id])
        student.update!(name: params[:name], instructor_id: params[:instructor_id], age: params[:age], major: params[:major])
        render json: student, status: :accepted
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private

    def render_not_found_response
        render json: { error: "Student not found" }, status: :not_found
    end

    def render_invalid_record_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

end
