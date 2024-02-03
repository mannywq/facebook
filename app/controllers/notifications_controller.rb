class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /notifications or /notifications.json
  def index
    pending = Friendship.where.not(initiator: current_user,
                                   status: %i[accepted
                                              ignored]).where.not(user: current_user)

    @invites = pending.map(&:user)
  end

  # GET /notifications/1 or /notifications/1.json
  def show; end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit; end

  # POST /notifications or /notifications.json
  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html do
          redirect_to notification_url(@notification),
                      notice: 'Notification was successfully created.'
        end
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @notification.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /notifications/1 or /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html do
          redirect_to notification_url(@notification),
                      notice: 'Notification was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @notification.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /notifications/1 or /notifications/1.json
  def destroy
    @notification.destroy!

    respond_to do |format|
      format.html do
        redirect_to notifications_url,
                    notice: 'Notification was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_notification
    @notification = Notification.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def notification_params
    params.fetch(:notification, {})
  end
end
