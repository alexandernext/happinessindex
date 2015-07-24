class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /scores
  # GET /scores.json
  def index
    redirect_to today_scores_path
  end

  # GET /scores/1
  # GET /scores/1.json
  def show
  end

  def week
    @last_seven_days = [Date.today, Date.today - 1, Date.today - 2, Date.today - 3, Date.today - 4, Date.today - 5, Date.today - 6]
    @morning_scores = current_user.scores.where("day > ?", Date.today - 7).where(:time_of_day => "morning")
    @afternoon_scores = current_user.scores.where("day > ?", Date.today - 7).where(:time_of_day => "afternoon")
    @evening_scores = current_user.scores.where("day > ?", Date.today - 7).where(:time_of_day => "evening")
  end

  # GET /scores/today
  # GET /scores/today.json
  def today
    @scores = current_user.scores.where(:day => Date.today)
  end

  # GET /scores/new
  def new
    @score = Score.new
  end

  # GET /scores/1/edit
  def edit
  end

  # POST /scores
  # POST /scores.json
  def create
    @score = Score.new(score_params)

    respond_to do |format|
      if @score.save
        format.html { redirect_to today_scores_path, notice: '完成新增。' }
        format.json { redirect_to today_scores_path, status: :created }
      else
        format.html { render :new }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /scores/1
  # PATCH/PUT /scores/1.json
  def update
    respond_to do |format|
      if @score.update(score_params)
        format.html { redirect_to today_scores_path, notice: '完成更新。' }
        format.json { redirect_to today_scores_path, status: :ok, location: @score }
      else
        format.html { render :edit }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    @score.destroy
    respond_to do |format|
      format.html { redirect_to scores_url, notice: '成功刪除。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.require(:score).permit(:value, :description, :day, :time_of_day, :user_id)
    end
end
