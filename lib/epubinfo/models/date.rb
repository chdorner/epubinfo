require 'time'

module EPUBInfo
  module Models
    class Date
      # Date ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.7 EPUB2 reference})
      # @return Date
      attr_accessor :date
      # Date as a string ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.7 EPUB2 reference})
      # @return String
      attr_accessor :date_str
      # Event ({http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2.7 EPUB2 reference})
      # @return String
      attr_accessor :event

      # Should never be called directly, go through EPUBInfo.get
      def initialize(node)
        self.date = Utils.parse_iso_8601_date(node.content) rescue nil
        self.date_str = node.content
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

