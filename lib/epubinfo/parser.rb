module EPUBInfo
  class Parser
    attr_accessor :path, :metadata_document

    def self.parse(path)
      epubinfo = EPUBInfo::Parser.new
      epubinfo.path = path
      epubinfo
    end

    def metadata_document
      @metadata_document ||= load_metadata_file
    end

    def drm_protected?
      @drm_protected ||= !!zip_file.find_entry('META-INF/rights.xml')
    end

    private

    def zip_file
      @zip_file ||= Zip::ZipFile.open(@path)
    end

    def root_document
      @root_document ||= Nokogiri::XML(zip_file.read('META-INF/container.xml'))
    end

    def metadata_path
      root_document.css('container rootfiles rootfile:first-child').attribute('full-path').content
    end

    def load_metadata_file
      Nokogiri::XML(zip_file.read(metadata_path))
    end
  end
end
