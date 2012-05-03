require 'spec_helper'

describe EPUBInfo::Models::Date do
  describe '#initialize' do
    subject { EPUBInfo::Models::Date.new(Nokogiri::XML(File.new('spec/support/xml/metamorphosis_metadata_epub2.opf')).css('metadata').xpath('.//dc:date').first) }

    its(:date) { should == Date.new(2005, 8, 17) }
    its(:date_str) { should == '2005-08-17' }
    its(:event) { should == 'publication' }
  end

  describe '#to_hash' do
    context 'keys' do
      subject { EPUBInfo::Models::Date.new(Nokogiri::XML(File.new('spec/support/xml/metamorphosis_metadata_epub2.opf')).css('metadata').xpath('.//dc:date').first).to_hash.keys }
      it { should include :time }
      it { should include :event }
    end
  end
end
