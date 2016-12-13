class BrosController < ApplicationController

  def index
    @bros = Unirest.get("http://localhost:3001/api/v2/bros.json").body
  end

  def show 
    @bro = Unirest.get("http://localhost:3001/api/v2/bros/#{params[:id]}.json").body
  end

  def create
    Unirest.post("http://localhost:3001/api/v2/bros/",
      headers:{"Accept" => "application/json"},
      parameters:{
        name: params[:input_name],
        bio:params[:input_bio],
        fav_food:params[:input_fav_food],
        job: params[:input_job]
      }
    )
    redirect_to :index
  end

  def new
  end
end
