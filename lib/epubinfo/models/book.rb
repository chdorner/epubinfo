module EPUBInfo
  module Models
    class Book
      attr_accessor :titles, :creators, :subjects, :description,
        :publisher, :contributors, :dates, :identifiers,
        :source, :languages, :rights

      def initialize(document)
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

