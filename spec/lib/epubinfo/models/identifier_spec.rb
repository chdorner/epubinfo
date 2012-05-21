require 'spec_helper'

describe EPUBInfo::Models::Identifier do
  describe '#initialize' do
    context 'EPUB2' do
      subject { EPUBInfo::Models::Identifier.new(Nokogiri::XML(File.new('spec/support/xml/metamorphosis_metadata_epub2.opf')).remove_namespaces!.css('metadata').xpath('.//identifier').first) }

      its(:identifier) { should == 'http://www.gutenberg.org/ebooks/5200' }
      its(:scheme) { should == 'URI' }
    end

    context 'EPUB3' do
      subject { EPUBInfo::Models::Identifier.new(Nokogiri::XML(File.new('spec/support/xml/wasteland_metadata_epub3.opf')).remove_namespaces!.css('metadata').xpath('.//identifier').first) }

      its(:identifier) { should == 'code.google.com.epub-samples.wasteland-basic' }
    end
  end

  describe '#to_hash' do
    context 'keys' do
      subject { EPUBInfo::Models::Identifier.new(Nokogiri::XML(File.new('spec/support/xml/metamorphosis_metadata_epub2.opf')).remove_namespaces!.css('metadata').xpath('.//identifier').first).to_hash.keys }
      it { should include :identifier }
      it { should include :scheme }
    end
  end
end

