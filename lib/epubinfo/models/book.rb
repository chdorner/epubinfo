module EPUBInfo
  module Models
    class Book
      attr_accessor :titles, :creators, :subjects, :description,
        :publisher, :contributors, :dates, :identifiers,
        :source, :languages, :rights

      def initialize(document)
        metadata = document.css('metadata')
        self.titles = metadata.xpath('.//dc:title').map(&:content)
        self.creators = metadata.xpath('.//dc:creator').map {|c| EPUBInfo::Models::Person.new(c) }
        self.subjects = metadata.xpath('.//dc:subject').map(&:content)
        self.description = metadata.xpath('.//dc:description').first.content rescue nil
        self.publisher = metadata.xpath('.//dc:publisher').first.content rescue nil
        self.contributors = metadata.xpath('.//dc:contributor').map {|c| EPUBInfo::Models::Person.new(c) }
        self.dates = metadata.xpath('.//dc:date').map { |d| EPUBInfo::Models::Date.new(d) }
        self.identifiers = metadata.xpath('.//dc:identifier').map { |i| EPUBInfo::Models::Identifier.new(i) }
        self.source = metadata.xpath('.//dc:source').first.content rescue nil
        self.languages = metadata.xpath('.//dc:language').map(&:content)
        self.rights = metadata.xpath('.//dc:rights').first.content rescue nil
      end

      def titles; @titles || []; end
      def creators; @creators || []; end
      def subjects; @subjects || []; end
      def contributors; @contributors || []; end
      def dates; @dates || []; end
      def identifiers; @identifiers || []; end
      def languages; @languages || []; end
    end
  end
end

