module EPUBInfo
  class Parser
    attr_accessor :path, :metadata_document

    def self.parse(path_io)
      epubinfo = EPUBInfo::Parser.new
      epubinfo.path =  path_io.is_a?(IO) ? path_io.path : path_io
      epubinfo
    end

    def metadata_document
      @metadata_document ||= load_metadata_file
    end

    def drm_protected?
      @drm_protected ||= !!zip_file.find_entry('META-INF/rights.xml')
    end

    def zip_file
      begin
        @zip_file ||= Zip::ZipFile.open(@path)
      rescue Zip::ZipError => e
        raise NotAnEPUBFileError.new(e)
      end
    end

    def metadata_path
      @metadata_path ||= begin
        root_document.remove_namespaces!
        root_document.css('container rootfiles rootfile:first-child').attribute('full-path').content
      end
    end

    def metadata_type
      @metadata_type ||= begin
        root_document.remove_namespaces!
        root_document.css('container rootfiles rootfile:first-child').attribute('media-type').content
      end
    end

    private

    def root_document
      begin
        @root_document ||= Nokogiri::XML(zip_file.read('META-INF/container.xml'))
      rescue => e
        raise NotAnEPUBFileError.new(e)
      end
    end

    def load_metadata_file
      Nokogiri::XML(zip_file.read(metadata_path))
    end
  end
end
