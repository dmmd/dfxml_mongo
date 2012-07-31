require 'mongo'
require './config/mongo_config'
module MongoDFXML
  class DfxmlDB
    attr :connection, :collection, :db
    
    def initialize
      @connection = Mongo::Connection.new
      @collection = @connection[COL_NAME]
      @db = @collection[DB_NAME]
    end
    
    def save(image)
      @db.save(image)
    end  
  end
end