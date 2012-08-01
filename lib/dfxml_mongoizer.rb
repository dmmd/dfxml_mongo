module DfxmlProcessor
  class DfxmlFile
    attr :filename, :file_id, :from_image, :data, :image_filename, :image_fstype, :image_hash, :files
    
    def initialize(doc_path)
      @image_hash = Hash.new
      @files = Array.new
      @filename = doc_path
      if File.extname(doc_path) == '.xml'
        @from_image = false
      else
        @data = %x[fiwalk -c config/ficonfig.txt -fx #{doc_path}]
        @from_image = true
      end
      @file_id = val_to_id File.basename(doc_path, '.*')
      self.parse
      self.build_hash
    end
     
    def val_to_id(v)
      v.downcase.gsub('\s+', '_').gsub(/\W+/, '_').gsub(/ /, '_').gsub(/\.xml/, '').gsub(/^ +| $/, '')
    end
    
    def path p
       path = p.split('/')
       path[0..-2].join('/')
    end
    
    def build_hash
      @image_hash['image_filename'.to_sym] = @image_filename
      @image_hash['image_fstype'.to_sym] = @image_fstype
      @image_hash['image_blk_size'.to_sym] = @blk_size
      @image_hash['image_blk_count'.to_sym] = @blk_count
      @image_hash['files'.to_sym] = @files
    end
    
    def parse
      if @from_image
        reader = Nokogiri::XML::Reader(@data)
      else
        reader = Nokogiri::XML::Reader(File.new(@filename))
      end
      while reader.read
        if reader.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT and reader.name == 'image_filename'
          @image_filename = reader.read.value
        elsif reader.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT and reader.name == 'volume'
          volume = Dfxml::Parser::Volume.parse(reader.outer_xml)
          @image_fstype = volume.ftype
          @blk_size = volume.block_size
          @blk_count = volume.block_count
        elsif reader.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT and reader.name == 'fileobject'
          fileobject = Dfxml::Parser::FileObject.parse(reader.outer_xml)
          doc = {
            :filename => fileobject.filename,
            :filesize => fileobject.filesize,
            :path => '/' + path(fileobject.filename),
            :alloc => fileobject.alloc
          }
          
          if fileobject.pronom_format != nil
            doc[:pronom_format] = fileobject.pronom_format
            doc[:pronom_puid] = fileobject.pronom_puid
            doc[:pronom_identification_method] = fileobject.pronom_identification_method
          end
          
          files.push(doc)
        end
      end
    end
  end
end