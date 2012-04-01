require 'spec_helper'

describe EPUBInfo::Models::Date do
  subject { EPUBInfo::Models::Date.new(Nokogiri::XML(File.new('spec/support/xml/metamorphosis_metadata_epub2.opf')).css('metadata').xpath('.//dc:date').first) }

  its(:time) { should == Time.parse('2005-08-17') }
  its(:event) { should == 'publication' }
end
