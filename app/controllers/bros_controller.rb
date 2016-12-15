class BrosController < ApplicationController

  def index
    unirest_data = Unirest.get("#{ENV['API_URL']}/bros.json").body
    @bros = Array.new
    unirest_data.each do |data_hash|
      @bros.push(Bro.new(data_hash))
    end
  end

  def show 
    unirest_data = Unirest.get("#{ENV['API_URL']}/bros/#{params[:id]}.json").body
    @bro = Bro.new(unirest_data)
  end

  def create
    response = Unirest.post("#{ENV['API_URL']}/bros/",
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
    @bro = Unirest.get("#{ENV['API_URL']}/bros/#{params[:id]}.json").body
  end

  def update
    response = Unirest.patch("#{ENV['API_URL']}/bros/#{params[:id]}",
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

  def destroy
    response = Unirest.delete("#{ENV['API_URL']}/bros/#{params[:id]}")
    redirect_to bros_path
  end
end
