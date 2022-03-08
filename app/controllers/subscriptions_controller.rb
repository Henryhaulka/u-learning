class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[ show edit update destroy ]
  before_action :set_course, only: [:new, :create ]
  # GET /subscriptions or /subscriptions.json
  def index
    @subscriptions = Subscription.all
    authorize  @subscriptions
  end

  # GET /subscriptions/1 or /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
    authorize  @subscription
  end

  # POST /subscriptions or /subscriptions.json
  def create
    if @course.price > 0
      flash[:alert] = "You can't access paid courses yet"
      redirect_to new_course_subscription_path(@course)
    else
      current_user.buy_a_course(@course)
      flash[:notice] = "You have successfully subscribe to #{@course.title}"
      redirect_to course_path(@course)
    end
  end

  # PATCH/PUT /subscriptions/1 or /subscriptions/1.json
  def update
    authorize  @subscription
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to subscription_url(@subscription), notice: "Subscription was successfully updated." }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1 or /subscriptions/1.json
  def destroy
      authorize  @subscription
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: "Subscription was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end
    
    def set_course
      @course = Course.friendly.find(params[:course_id])
    end
    
    # Only allow a list of trusted parameters through.
    def subscription_params
      params.require(:subscription).permit(:review, :rating)
    end
end
