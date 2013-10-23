require 'epubinfo/models/table_of_contents/resource'

module EPUBInfo
  module Models
    class TableOfContents
      def initialize(parser)
        document = parser.metadata_document
        document_type = parser.metadata_type

        return if document.nil? || !document_type.eql?("application/oebps-package+xml")
        document.remove_namespaces!
        metadata = document.css('metadata')
        self.spine = metadata.xpath('//spine')
        self.manifest = metadata.xpath('//manifest')
        self.parser = parser
      end


      def type
        spine.first.attr('toc')
      end

      def resources
        @resources ||= Resource.new(self)
      end

      def document
        @toc_document ||= load_toc_file.remove_namespaces!
      end

      def path
        @toc_path ||= begin
          toc_id = spine[0]['toc']
          toc_ncx = manifest.xpath("item[@id = '#{toc_id}']").first.attr('href')
          parser.zip_file.entries.map { |p| p.name }.select { |s| s.match(toc_ncx) }.first
        end

      end

      attr_accessor :manifest
      attr_accessor :parser
      attr_accessor :spine

      private
      def load_toc_file
        Nokogiri::XML(parser.zip_file.read(path))
      end

    end
  end
end