class WelcomeController < ApplicationController
  def home
  	Proccessed.destroy_all
  	Website.destroy_all
  end

  def results
  	website = Website.create(url: params[:url], depth_level: 1, title: params[:url])
  	Crawler.new(website, params[:depth].to_i, params[:time].to_i)
  end
end
