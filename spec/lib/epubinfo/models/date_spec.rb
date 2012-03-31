require 'spec_helper'

describe EPUBInfo::Models::Date do
  subject { EPUBInfo::Models::Date.new(Nokogiri::XML(File.new('spec/support/xml/metamorphosis_metadata.opf')).css('metadata').xpath('.//dc:date').first) }

  its(:time) { should == Time.parse('2005-08-17') }
  its(:event) { should == 'publication' }
end
