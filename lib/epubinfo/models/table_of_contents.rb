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
        @resources ||=
            begin
              resources = []
              spine.first.xpath('./itemref').map {|s| s['idref']}.each do |item_ref|
                resource = manifest.css("##{item_ref}").first
                if resource
                  uri = resource.attr('href')
                  mime_type = resource.attr('media-type')
                  label = ''
                  uri_ref = ''
                  order = ''

                  nav_point = document.xpath("//navPoint[starts-with(content/@src,'#{uri}')]").first
                  if nav_point
                    label = nav_point.at('navLabel text').content || ''
                    uri_ref = nav_point.at('content').attr('src') || ''
                    order   = nav_point.attr('playOrder') || ''
                  end

                  resources << {:id      => item_ref,
                                :uri     => parser.zip_file.entries.map {|p| p.name}.select{|s| s.match(uri)}.first,
                                :uri_ref => uri_ref,
                                :text    => label,
                                :type    => mime_type,
                                :order   => order}
                end
              end
              resources
            end
      end

      def document
        @toc_document ||= load_toc_file.remove_namespaces!
      end

      def path
        @toc_path ||= begin
          toc_id = spine[0]['toc']
          toc_ncx = manifest.xpath("item[@id = '#{toc_id}']").first.attr('href')
          parser.zip_file.entries.map {|p| p.name}.select{|s| s.match(toc_ncx)}.first
        end

      end

      private
      attr_accessor :manifest
      attr_accessor :parser
      attr_accessor :spine

      def load_toc_file
        Nokogiri::XML(parser.zip_file.read(path))
      end

    end
  end
end