class Admin::ModelsController < ApplicationController
  include PaginationUtils

  before_action :authenticate_user!
  before_action :set_model, only: [:show, :edit, :update, :destroy]

  def index
    @models = Model.paginate(page: params[:page])
  end

  def show
  end

  def new
    @model = Model.new
  end

  def edit
  end

  def create
    @model = Model.new(model_params)

    respond_to do |format|
      if @model.save
        format.html { redirect_to admin_models_url(page: last_page(:model)),
                                  notice: I18n.translate('model.flash.actions.create.notice') }
        format.json { render :index, status: :created, location: admin_models_url(page: last_page(:model)) }
      else
        format.html { render :new }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @model.update(model_params)
        format.html { redirect_to admin_model_url(@model, page: current_page),
                                  notice: I18n.translate('model.flash.actions.update.notice') }
        format.json { render :show, status: :ok, location: admin_model_url(@model, page: current_page) }
      else
        format.html { render :edit }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @model.destroy

    respond_to do |format|
      page = last_page :model
      if not page.nil? and page > current_page.to_i
        page = current_page
      end

      format.html { redirect_to admin_models_url(page: page),
                                notice: I18n.translate('model.flash.actions.destroy.notice') }
      format.json { head :no_content }
    end
  end

  private

  def set_model
    @model = Model.find(params[:id])
  end

  def model_params
    params.require(:model).permit(:name, :description, :photo_album_id, :favorite)
  end
end
