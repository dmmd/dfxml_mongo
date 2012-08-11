require 'sinatra'
require './lib/mongo'
require './lib/dfxml'
require './lib/dfxml/parser'
require './lib/dfxml_mongoizer'



def getTitle(cid, coll)
  return coll.db.find({"cid" => cid}, {:fields => ['title']}).next['title']
end

get '/image/:image_fn' do
  images = MongoDFXML::DfxmlDB.new
  coll = MongoDFXML::CollDB.new
  resource = params[:image_fn]
  result = images.db.find(:image_filename => resource)
  @record = result.next
  erb :image
end

get '/file' do
  images = MongoDFXML::DfxmlDB.new
  coll = MongoDFXML::CollDB.new
  @image = images.db.find(:image_filename => params[:image]).next
  @id = params[:file]
  erb :file
end

get '/images' do
  images = MongoDFXML::DfxmlDB.new
  coll = MongoDFXML::CollDB.new
  @cols = Hash.new
  images.db.find({"image_filename" => /^./}, {:fields => ['image_filename']}).each do |image|
    col = /\w{1}\d*/.match image['image_filename']
    if @cols.include? col[0]
      @cols[col[0]][:files].push image['image_filename']
    else
      title =  getTitle(col[0], coll)
      @cols[col[0]] = {:title => title, :files => [image['image_filename']]}
    end
  end
  
  erb :images
end