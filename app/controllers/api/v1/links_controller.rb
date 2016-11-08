class Api::V1::LinksController < ApplicationController
  respond_to :json

  def index
    if current_user && params[:ordered]
      respond_with current_user.links.order(:title)
    elsif current_user
      respond_with current_user.links
    else
      respond_with 'Authentication required', status: 400
    end
  end

  def update
    if current_user
      link = Link.find(params[:id])
      link.update_attribute(:read, params[:read])
    else
      render json: {}, status: 400
    end
  end
end
