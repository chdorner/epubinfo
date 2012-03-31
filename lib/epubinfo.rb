require 'zip/zip'
require 'nokogiri'

require 'epubinfo/parser'
require 'epubinfo/models/book'
require 'epubinfo/models/person'
require 'epubinfo/models/date'
require 'epubinfo/models/identifier'

module EPUBInfo
  def self.get(path)
    parser = EPUBInfo::Parser.parse(path)
  end
end
