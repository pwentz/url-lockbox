class LinksController < ApplicationController
  def index
    @links = current_user.links
  end

  def create
    @link = Link.create(title: params[:link][:title],
                       url: params[:link][:url],
                       user: current_user)
    if @link.valid?
      current_user.links << @link
    end

    render :index
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
