class LinksController < ApplicationController
  before_action :verify_permissions

  def index
    @links = current_user.links
    @link = Link.new unless @link
  end

  def create
    @link = Link.new(title: params[:link][:title],
                     url: params[:link][:url],
                     user: current_user)
    if @link
      current_user.links << @link
    end

    render :index
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      redirect_to links_path
    else
      render :edit
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end

  def verify_permissions
    render file: '/public/unauthorized_access' unless current_user
  end
end
