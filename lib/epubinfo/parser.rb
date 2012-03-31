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

    private

    def load_epub
      @zipfile = Zip::ZipFile.open(@path)
    end

    def load_root_file
      load_epub if @zipfile.nil?
      @root_document = Nokogiri::XML(@zipfile.read('META-INF/container.xml'))
    end

    def metadata_path
      load_root_file if @root_document.nil?
      @root_document.css('container rootfiles rootfile:first-child').attribute('full-path').content
    end

    def load_metadata_file
      load_epub if @zipfile.nil?
      Nokogiri::XML(@zipfile.read(metadata_path))
    end
  end
end
