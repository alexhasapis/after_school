class SafetyReportsController < ApplicationController
  before_action :set_safety_report, only: [:show, :edit, :update, :destroy]

  # GET /safety_reports
  # GET /safety_reports.json
  def index
    @safety_reports = SafetyReport.all
  end

  # GET /safety_reports/1
  # GET /safety_reports/1.json
  def show
  end

  # GET /safety_reports/new
  def new
    @safety_report = SafetyReport.new
  end

  # GET /safety_reports/1/edit
  def edit
  end

  # POST /safety_reports
  # POST /safety_reports.json
  def create
    @safety_report = SafetyReport.new(safety_report_params)

    respond_to do |format|
      if @safety_report.save
        format.html { redirect_to @safety_report, notice: 'Safety report was successfully created.' }
        format.json { render :show, status: :created, location: @safety_report }
      else
        format.html { render :new }
        format.json { render json: @safety_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /safety_reports/1
  # PATCH/PUT /safety_reports/1.json
  def update
    respond_to do |format|
      if @safety_report.update(safety_report_params)
        format.html { redirect_to @safety_report, notice: 'Safety report was successfully updated.' }
        format.json { render :show, status: :ok, location: @safety_report }
      else
        format.html { render :edit }
        format.json { render json: @safety_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /safety_reports/1
  # DELETE /safety_reports/1.json
  def destroy
    @safety_report.destroy
    respond_to do |format|
      format.html { redirect_to safety_reports_url, notice: 'Safety report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_safety_report
      @safety_report = SafetyReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def safety_report_params
      params.require(:safety_report).permit(:building, :dbn, :major_crimes, :other_crimes, :incidents, :property_crimes, :violent_crimes, :group_size, :avg_major_crimes, :avg_other_crimes, :avg_incidents, :avg_property_crimes, :avg_violent_crimes)
    end
end
