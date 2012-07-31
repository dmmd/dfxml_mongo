require './lib/mongo'
require './lib/dfxml'
require './lib/dfxml/parser'
require './lib/file_manager'

dfxml = DfxmlProcessor::DfxmlFile.new('resources/M1126-0007.001')
mongo = MongoDFXML::DfxmlDB.new

mongo.db.remove()
mongo.db.save(dfxml.image_hash)
result = mongo.db.find(:image_filename => dfxml.image_filename)
printf(dfxml.image_filename + " [" + dfxml.image_fstype + "]\n")

if(result.has_next?)
  result.next['files'].each do |file|
    if file['pronom_format'] != nil
      puts "\t" << file['filename'] << "\t" << file['pronom_format'].to_s
    end
  end
end