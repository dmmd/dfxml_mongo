require './lib/mongo'
require './lib/dfxml'
require './lib/dfxml/parser'
require './lib/dfxml_mongoizer'

mongo = MongoDFXML::DfxmlDB.new

mongo.db.remove()
dfxml = DfxmlProcessor::DfxmlFile.new('resources/M1126-0022.xml')
mongo.db.save(dfxml.image_hash)
#dfxml = DfxmlProcessor::DfxmlFile.new('resources/M18400-0007.xml')
#mongo.db.save(dfxml.image_hash)
