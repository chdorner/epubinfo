module EPUBInfo
  module Models
    class Identifier
      attr_accessor :identifier, :scheme

      def initialize(node)
        self.identifier = node.content
        self.scheme = node.attribute('scheme').content rescue nil
      end
    end
  end
end

