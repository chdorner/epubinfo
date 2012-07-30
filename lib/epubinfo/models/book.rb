module EPUBInfo
  module Models
    class Book
      # Titles, array of String instances ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.1 EPUB2 reference})
      # @return [Array]
      attr_accessor :titles
      def titles; @titles || []; end

      # Creators, array of Person instances ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.2 EPUB2 reference})
      # @return [Array]
      attr_accessor :creators
      def creators; @creators || []; end

      # Subjects, array of String instances ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.3 EPUB2 reference})
      # @return [Array]
      attr_accessor :subjects
      def subjects; @subjects || []; end

      # Description ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.4 EPUB2 reference})
      # @return [String]
      attr_accessor :description

      # Publisher ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.5 EPUB2 reference})
      # @return [String]
      attr_accessor :publisher

      # Contributors, array of Person instances ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.6 EPUB2 reference})
      # @return [Array]
      attr_accessor :contributors
      def contributors; @contributors || []; end

      # Dates, array of Date instances ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.7 EPUB2 reference})
      # @return [Array]
      attr_accessor :dates
      def dates; @dates || []; end

      # Identifiers, array of Identifier instances ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.10 EPUB2 reference})
      # @return [Array]
      attr_accessor :identifiers
      def identifiers; @identifiers || []; end

      # Source ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.11 EPUB2 reference})
      # @return [String]
      attr_accessor :source

      # Languages, array of String instances ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.12 EPUB2 reference})
      # @return [Array]
      attr_accessor :languages
      def languages; @languages || []; end

      # Rights ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.15 EPUB2 reference})
      # @return [String]
      attr_accessor :rights

      # DRM protected
      # @return [Boolean]
      attr_accessor :drm_protected
      def drm_protected; @drm_protected || false; end
      alias :drm_protected? :drm_protected

      # Cover
      # @return [Cover]
      attr_accessor :cover

      # Should never be called directly, go through EPUBInfo.get
      def initialize(parser)
        document = parser.metadata_document
        return if document.nil?
        document.remove_namespaces!
        metadata = document.css('metadata')
        self.titles = metadata.xpath('.//title').map(&:content)
        self.creators = metadata.xpath('.//creator').map {|c| EPUBInfo::Models::Person.new(c) }
        self.subjects = metadata.xpath('.//subject').map(&:content)
        self.description = metadata.xpath('.//description').first.content rescue nil
        self.publisher = metadata.xpath('.//publisher').first.content rescue nil
        self.contributors = metadata.xpath('.//contributor').map {|c| EPUBInfo::Models::Person.new(c) }
        self.dates = metadata.xpath('.//date').map { |d| EPUBInfo::Models::Date.new(d) }
        self.identifiers = metadata.xpath('.//identifier').map { |i| EPUBInfo::Models::Identifier.new(i) }
        self.source = metadata.xpath('.//source').first.content rescue nil
        self.languages = metadata.xpath('.//language').map(&:content)
        self.rights = metadata.xpath('.//rights').first.content rescue nil
        self.drm_protected = parser.drm_protected?
        self.cover = EPUBInfo::Models::Cover.new(parser)
      end


      # Returns Hash representation of the book
      # @return [Hash]
      def to_hash
        {
          :titles => @titles,
          :creators => @creators.map(&:to_hash),
          :subjects => @subjects,
          :description => @description,
          :publisher => @publisher,
          :contributors => @contributors.map(&:to_hash),
          :dates => @dates.map(&:to_hash),
          :identifiers => @identifiers.map(&:to_hash),
          :source => @source,
          :languages => @languages,
          :rights => @rights,
          :drm_protected => @drm_protected,
          :cover => @cover,
        }
      end
    end
  end
end

