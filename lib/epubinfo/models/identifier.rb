module EPUBInfo
  module Models
    class Identifier
      # Identifier ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.1 EPUB2 reference})
      # @return [String]
      attr_accessor :identifier
      # Scheme ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.1 EPUB2 reference})
      # @return [String]
      attr_accessor :scheme

      # Should never be called directly, go through EPUBInfo.get
      def initialize(node)
        self.identifier = node.content
        self.scheme = node.attribute('scheme').content rescue nil
      end

      # Returns Hash representation of an identifier
      # @return [Hash]
      def to_hash
        {
          :identifier => @identifier,
          :scheme => @scheme
        }
      end
    end
  end
end

