require 'zip/zip'
require 'nokogiri'

require 'epubinfo/parser'
require 'epubinfo/model'

module EPUBInfo
  def self.get(path)
    parser = EPUBInfo::Parser.parse(path)
  end
end
