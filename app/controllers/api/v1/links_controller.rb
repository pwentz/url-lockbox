class Api::V1::LinksController < ApplicationController
  skip_before_action :verify_permissions
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
    link = Link.find(params[:id])
    link.update_attribute(:read, params[:read])
  end
end
