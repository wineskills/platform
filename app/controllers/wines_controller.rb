class WinesController < ApplicationController
  breadcrumb :wines, :wines_path

  def index
    @pagy, @wines = pagy(Wine.includes(:region).with_attached_picture)
  end

  def show
    @wine = Wine.includes(:grapes, :harmonizes).find(params[:id]).decorate
    breadcrumb @wine.name, @wine
  end
end
