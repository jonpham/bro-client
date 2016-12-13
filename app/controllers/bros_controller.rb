class BrosController < ApplicationController

  def index
    @bros = Unirest.get("http://localhost:3001/api/v2/bros.json").body
  end

  def show 
    @bro = Unirest.get("http://localhost:3001/api/v2/bros/#{params[:id]}.json").body
  end

  def create
    response = Unirest.post("http://localhost:3001/api/v2/bros/",
      headers:{"Accept" => "application/json"},
      parameters:{
        name: params[:input_name],
        bio:params[:input_bio],
        fav_food:params[:input_fav_food],
        job: params[:input_job]
      }
    )
    redirect_to "/bros/#{response.body['id']}"
  end

  def new
  end

  def edit
    @bro = Unirest.get("http://localhost:3001/api/v2/bros/#{params[:id]}.json").body
  end

  def update
    response = Unirest.patch("http://localhost:3001/api/v2/bros/#{params[:id]}",
      headers:{"Accept" => "application/json"},
      parameters:{
        name: params[:input_name],
        bio:params[:input_bio],
        fav_food:params[:input_fav_food],
        job: params[:input_job]
      }
    )
    redirect_to "/bros/#{response.body['id']}"
  end
end
