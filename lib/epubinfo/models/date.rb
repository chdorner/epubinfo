require 'time'

module EPUBInfo
  module Models
    class Date
      # Time ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.7 EPUB2 reference})
      # @return [Time]
      attr_accessor :time
      # Event ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.7 EPUB2 reference})
      # @return [String]
      attr_accessor :event

      # Should never be called directly, go through EPUBInfo.get
      def initialize(node)
        self.time = Time.parse(node.content)
        self.event = node.attribute('event').content rescue nil
      end

      # Returns Hash representation of a date
      # @return [Hash]
      def to_hash
        {
          :time => @time,
          :event => @event
        }
      end
    end
  end
end

