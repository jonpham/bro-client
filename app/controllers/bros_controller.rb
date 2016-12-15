class BrosController < ApplicationController

  def index
    @bros = Bro.get_all
  end

  def show 
    @bro = Bro.find_by_id(params[:id])
  end

  def create
    bro.new({name: params[:input_name],
        bio:params[:input_bio],
        fav_food:params[:input_fav_food],
        job: params[:input_job]})
    response = bro.post
    redirect_to "/bros/#{response.body['id']}"
  end

  def new
  end

  def edit
    @bro = Bro.find_by_id(params[:id])
  end

  def update
    bro = Bro.find_by_id(params[:id])
    response = bro.update({name: params[:input_name], bio: params[:input_bio],
      fav_food: params[:input_fav_food], job: params[:input_job]})
    redirect_to "/bros/#{response.body['id']}"
  end

  def destroy
    bro = Bro.find_by_id(params[:id])
    response = bro.destroy
    redirect_to bros_path
  end
end
