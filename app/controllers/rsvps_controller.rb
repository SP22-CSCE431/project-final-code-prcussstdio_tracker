class RsvpsController < ApplicationController
  before_action :set_rsvp, only: %i[ show edit update destroy ]

  # GET /rsvps or /rsvps.json
  def index
    @rsvps = Rsvp.all
  end

  # GET /rsvps/1 or /rsvps/1.json
  def show
  end

  # GET /rsvps/new
  def new
    @rsvp = Rsvp.new(rsvp_params)
  end

  # GET /rsvps/1/edit
  def edit
  end

  # POST /rsvps or /rsvps.json
  def create
    @rsvp = Rsvp.new(rsvp_params)

    respond_to do |format|
      if @rsvp.save
        format.html { redirect_to events_path, notice: "Rsvp was successfully created." }
        format.json { render :show, status: :created, location: @rsvp }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rsvps/1 or /rsvps/1.json
  def update
    respond_to do |format|
      if @rsvp.update(rsvp_params) && valid_reason?
        format.html { redirect_to events_path, notice: "Rsvp was successfully updated." }
        format.json { render :show, status: :ok, location: @rsvp }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rsvps/1 or /rsvps/1.json
  def destroy
    @rsvp.destroy

    respond_to do |format|
      format.html { redirect_to rsvps_url, notice: "Rsvp was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rsvp
      @rsvp = Rsvp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rsvp_params
      params.require(:rsvp).permit(:user_id, :event_id, :rsvp_time, {:instrument_ids => []}, :attending, :reason)
    end

    # When not attending require a reason to be filled in the box
    def valid_reason?
      if @rsvp.attending == true
        return true
      end
      return !@rsvp.reason.empty?
    end
end
