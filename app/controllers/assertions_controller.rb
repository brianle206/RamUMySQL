class AssertionsController < ApplicationController
  before_action :set_assertion, only: [:bake_callback, :show, :edit, :update, :destroy]

  def bake_callback
    respond_to do |format|
      if @assertion and @assertion.uid = params[:uid]
        format.html { render :show }
        format.json { render json: @assertion.open_badges_as_json }
      else
        format.html { render text: 'Cannot access badge assertion.', status: :unauthorized }
        format.json {
          error = { status: 'failure', error: 'unauthorized', reason: 'Cannot access badge assertion.' }
          render json: error, status: :unauthorized
        }
      end
    end
  end

  # GET /assertions
  # GET /assertions.json
  def index
    @assertions = Assertion.all.sample(10)

    respond_to do |format|
      format.html
      format.json { render json: @assertions }
    end
  end

  # GET /assertions/1
  # GET /assertions/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @assertion }
    end
  end

  # GET /assertions/new
  def new
    @assertion = Assertion.new

    respond_to do |format|
      format.html
      format.json { render json: @assertion }
    end
  end

  # GET /assertions/1/edit
  def edit
  end

  # POST /assertions
  # POST /assertions.json
  def create
    @assertion = Assertion.new(assertion_params)
    @assertion[:verify] = { type: "hosted", url: "http://frozen-dawn-78535.herokuapp.com/assertions/#{@assertion.id}" }

    respond_to do |format|
      if @assertion.save
        format.html { redirect_to assertions_path, notice: 'Assertion was successfully created.' }
        format.json { render :show, status: :created, location: @assertion }
      else
        format.html { render :new }
        format.json { render json: @assertion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assertions/1
  # PATCH/PUT /assertions/1.json
  def update
    respond_to do |format|
      if @assertion.update(assertion_params)
        format.html { redirect_to @assertion, notice: 'Assertion was successfully updated.' }
        format.json { render :show, status: :ok, location: @assertion }
      else
        format.html { render :edit }
        format.json { render json: @assertion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assertions/1
  # DELETE /assertions/1.json
  def destroy
    @assertion.destroy
    respond_to do |format|
      format.html { redirect_to assertions_url, notice: 'Assertion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assertion
      @assertion = Assertion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assertion_params
      params.require(:assertion).permit(:user_id, :badge_id, :uid, :recipient, :badge, :issued_on, :expires)
    end
end
