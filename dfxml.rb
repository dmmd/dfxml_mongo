require 'sinatra'
require './lib/mongo'
require './lib/dfxml'
require './lib/dfxml/parser'
require './lib/file_manager'

mongo = MongoDFXML::DfxmlDB.new

get '/image/:image_fn' do
  resource = params[:image_fn]
  result = mongo.db.find(:image_filename => resource)
  @record = result.next
  
  erb :image
end