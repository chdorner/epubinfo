require 'time'

module EPUBInfo
  module Models
    class Date
      attr_accessor :time, :event

      def initialize(node)
        self.time = Time.parse(node.content)
        self.event = node.attribute('event').content rescue nil
      end

      def to_hash
        {
          :time => @time,
          :event => @event
        }
      end
    end
  end
end

