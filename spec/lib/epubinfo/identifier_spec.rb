require 'spec_helper'

describe EPUBInfo::Models::Identifier do
  subject { EPUBInfo::Models::Identifier.new(Nokogiri::XML(File.new('spec/support/xml/metamorphosis_metadata_epub2.opf')).css('metadata').xpath('.//dc:identifier').first) }

  its(:identifier) { should == 'http://www.gutenberg.org/ebooks/5200' }
  its(:scheme) { should == 'URI' }
end

