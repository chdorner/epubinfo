module EPUBInfo
  module Models
    class Date
      attr_accessor :time, :event

      def initialize(node)
        self.time = Time.parse(node.content)
        self.event = node.attribute('event').content rescue nil
      end
    end
  end
end

