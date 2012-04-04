module EPUBInfo
  module Models
    class Person
      # Name ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.6 EPUB2 reference})
      # @return [String]
      attr_accessor :name
      # File as ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.6 EPUB2 reference})
      # @return [String]
      attr_accessor :file_as
      # Role ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.6 EPUB2 reference})
      # @return [String]
      attr_accessor :role

      # Should never be called directly, go through EPUBInfo.get
      def initialize(node)
        self.name = node.content
        self.file_as = node.attribute('file-as').content rescue nil
        self.role = node.attribute('role').content rescue nil
      end

      # Returns Hash representation of a person
      # @return [Hash]
      def to_hash
        {
          :name => @name,
          :file_as => @file_as,
          :role => @role
        }
      end
    end
  end
end

