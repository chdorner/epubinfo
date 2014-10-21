module EPUBInfo
  module Models
    class ManifestItem
      # String ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.3 EPUB2 reference})
      # @return String
      attr_accessor :id
      # URI: a URI; if relative, the URI is interpreted as relative to the OPF Package Document file containing the reference ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.3 EPUB2 reference})
      # @return URI
      attr_accessor :href
      # String: specifying the item’s MIME media type ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.3 EPUB2 reference})
      # @return String
      attr_accessor :media_type

      # Should never be called directly, go through EPUBInfo.get
      def initialize(node)
        self.id         = node.attribute('id').content
        self.href       = node.attribute('href').content
        self.media_type = node.attribute('media-type').content
      end

      # Returns Hash representation of a item
      # @return [Hash]
      def to_hash
        {
          :id         => @id,
          :href       => @href,
          :media_type => @media_type
        }
      end
    end
  end
end
