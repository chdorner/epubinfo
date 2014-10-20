require 'zip'
require 'nokogiri'
require 'cgi'

require 'epubinfo/parser'
require 'epubinfo/models/book'
require 'epubinfo/models/cover'
require 'epubinfo/models/person'
require 'epubinfo/models/date'
require 'epubinfo/models/identifier'
require 'epubinfo/utils'

module EPUBInfo
  # Parses an epub file and returns a Book instance.
  # @return [EPUBInfo::Models::Book] a model representation of the epub file
  def self.get(path)
    parser = EPUBInfo::Parser.parse(path)
    EPUBInfo::Models::Book.new(parser)
  end
end
