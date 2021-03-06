class AfterSchoolProgramsController < ApplicationController
  before_action :set_after_school_program, only: [:show, :edit, :update, :destroy]

  # GET /after_school_programs
  # GET /after_school_programs.json
  def index
    @after_school_programs = AfterSchoolProgram.all
  end

  # GET /after_school_programs/1
  # GET /after_school_programs/1.json
  def show
  end

  # GET /after_school_programs/new
  def new
    @after_school_program = AfterSchoolProgram.new
  end

  # GET /after_school_programs/1/edit
  def edit
  end

  # POST /after_school_programs
  # POST /after_school_programs.json
  def create
    @after_school_program = AfterSchoolProgram.new(after_school_program_params)

    respond_to do |format|
      if @after_school_program.save
        format.html { redirect_to @after_school_program, notice: 'After school program was successfully created.' }
        format.json { render :show, status: :created, location: @after_school_program }
      else
        format.html { render :new }
        format.json { render json: @after_school_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /after_school_programs/1
  # PATCH/PUT /after_school_programs/1.json
  def update
    respond_to do |format|
      if @after_school_program.update(after_school_program_params)
        format.html { redirect_to @after_school_program, notice: 'After school program was successfully updated.' }
        format.json { render :show, status: :ok, location: @after_school_program }
      else
        format.html { render :edit }
        format.json { render json: @after_school_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /after_school_programs/1
  # DELETE /after_school_programs/1.json
  def destroy
    @after_school_program.destroy
    respond_to do |format|
      format.html { redirect_to after_school_programs_url, notice: 'After school program was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_school_progs
    lat = params[:lat]
    long = params[:long]

    search_query = AfterSchoolProgram.connection.select_all(" 
    SELECT *, ((ACOS(SIN(latitude * PI() / 180) * SIN(#{lat} * PI() / 180) + 
     COS(latitude * PI() / 180) * COS(#{lat} * PI() / 180) * COS((longitude - #{long}) * 
       PI() / 180)) * 180 / PI()) * 60 * 1.1515) AS distance
    FROM `after_school_programs`
    WHERE grade_age_level= 'High School' OR grade_age_level= '13 to 21' OR grade_age_level= '16 to 21'
    HAVING distance<=1")

    result = search_query.rows.map { |row| AfterSchoolProgram.find(row[0]) }
    render json: result
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_after_school_program
      @after_school_program = AfterSchoolProgram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def after_school_program_params
      params.require(:after_school_program).permit(:program, :program_type, :site, :boro, :agency, :grade_age_level, :latitude, :longitude)
    end
end
