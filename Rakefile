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
    
    task :add_dir do
      if File.directory? ENV['DIR']
        path = ENV['DIR'].dup
        dir = Dir.entries(ENV['DIR'])
        files = Array.new
        dir.each do |f|
          files.push(File.new(path + f))
        end
        
        files.each do |file|
          if File.extname(file) == ".xml"
            puts File.basename(file)
            dfxml = DfxmlProcessor::DfxmlFile.new(File.absolute_path(file))
            mongo.db.save(dfxml.image_hash)
          end  
        end
      else
        printf(ENV['DIR'] + 'is not a valid directory')
      end
    end
  end
end 