require 'mongo'
require './config/mongo_config'
module MongoDFXML
  class DfxmlDB
    attr :connection, :collection, :db
    
    def initialize
      @connection = Mongo::Connection.new
      @collection = @connection[COL_NAME]
      @db = @collection[IMAGE_DB]
    end
  end
  
  class CollDB
    attr :connection, :collection, :db
    
    def initialize
      @connection = Mongo::Connection.new
      @collection = @connection[COL_NAME]
      @db = @collection[COLL_DB]
    end
  end
end