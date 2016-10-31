class Api::V1::LinksController < ApplicationController
  skip_before_action :verify_permissions
  respond_to :json

  def index
    if current_user
      links = current_user.links

      respond_with links
    else
      respond_with 'Authentication required', status: 400
    end
  end

  def update
    link = Link.find(params[:id])
    link.update_attribute(:read, params[:read])
  end
end
