require './lib/mongo'
require './lib/dfxml'
require './lib/dfxml/parser'
require './lib/dfxml_mongoizer'

namespace :gumshoejr do
  namespace :db do
    mongo = MongoDFXML::DfxmlDB.new
    task :test do
      puts ENV['FILE']
    end
    task :clear do
      mongo.db.remove()      
    end
    task :add do
      dfxml = DfxmlProcessor::DfxmlFile.new(ENV['FILE'])            
      mongo.db.save(dfxml.image_hash)
    end 
  end
end 