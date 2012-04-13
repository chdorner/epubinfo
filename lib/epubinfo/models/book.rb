module EPUBInfo
  module Models
    class Book
      # Titles, array of String instances ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.1 EPUB2 reference})
      # @return [Array]
      attr_accessor :titles
      # Creators, array of Person instances ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.2 EPUB2 reference})
      # @return [Array]
      attr_accessor :creators
      # Subjects, array of String instances ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.3 EPUB2 reference})
      # @return [Array]
      attr_accessor :subjects
      # Description ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.4 EPUB2 reference})
      # @return [String]
      attr_accessor :description
      # Publisher ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.5 EPUB2 reference})
      # @return [String]
      attr_accessor :publisher
      # Contributors, array of Person instances ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.6 EPUB2 reference})
      # @return [Array]
      attr_accessor :contributors
      # Dates, array of Date instances ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.7 EPUB2 reference})
      # @return [Array]
      attr_accessor :dates
      # Identifiers, array of Identifier instances ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.10 EPUB2 reference})
      # @return [Array]
      attr_accessor :identifiers
      # Source ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.11 EPUB2 reference})
      # @return [String]
      attr_accessor :source
      # Languages, array of String instances ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.12 EPUB2 reference})
      # @return [Array]
      attr_accessor :languages
      # Rights ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.15 EPUB2 reference})
      # @return [String]
      attr_accessor :rights
      # DRM protected
      # @return [Boolean]
      attr_accessor :drm_protected
      def drm_protected; @drm_protected || false; end
      alias :drm_protected? :drm_protected

      # Should never be called directly, go through EPUBInfo.get
      def initialize(document, drm_protected = false)
        return if document.nil?
        metadata = document.css('metadata')
        self.titles = metadata.xpath('.//dc:title', EPUBInfo::Utils::DC_NAMESPACE).map(&:content)
        self.creators = metadata.xpath('.//dc:creator', EPUBInfo::Utils::DC_NAMESPACE).map {|c| EPUBInfo::Models::Person.new(c) }
        self.subjects = metadata.xpath('.//dc:subject', EPUBInfo::Utils::DC_NAMESPACE).map(&:content)
        self.description = metadata.xpath('.//dc:description', EPUBInfo::Utils::DC_NAMESPACE).first.content rescue nil
        self.publisher = metadata.xpath('.//dc:publisher', EPUBInfo::Utils::DC_NAMESPACE).first.content rescue nil
        self.contributors = metadata.xpath('.//dc:contributor', EPUBInfo::Utils::DC_NAMESPACE).map {|c| EPUBInfo::Models::Person.new(c) }
        self.dates = metadata.xpath('.//dc:date', EPUBInfo::Utils::DC_NAMESPACE).map { |d| EPUBInfo::Models::Date.new(d) }
        self.identifiers = metadata.xpath('.//dc:identifier', EPUBInfo::Utils::DC_NAMESPACE).map { |i| EPUBInfo::Models::Identifier.new(i) }
        self.source = metadata.xpath('.//dc:source', EPUBInfo::Utils::DC_NAMESPACE).first.content rescue nil
        self.languages = metadata.xpath('.//dc:language', EPUBInfo::Utils::DC_NAMESPACE).map(&:content)
        self.rights = metadata.xpath('.//dc:rights', EPUBInfo::Utils::DC_NAMESPACE).first.content rescue nil
        self.drm_protected = drm_protected
      end

      def creators; @creators || []; end
      def subjects; @subjects || []; end
      def contributors; @contributors || []; end
      def dates; @dates || []; end
      def identifiers; @identifiers || []; end
      def languages; @languages || []; end

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
          :drm_protected => @drm_protected
        }
      end
    end
  end
end

