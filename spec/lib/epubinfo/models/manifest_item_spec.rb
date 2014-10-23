require 'spec_helper'

describe EPUBInfo::Models::ManifestItem do
  context 'EPUB2' do
    describe '#initialize' do
      subject { EPUBInfo::Models::ManifestItem.new(Nokogiri::XML(File.new('spec/support/xml/metamorphosis_metadata_epub2.opf')).remove_namespaces!.css('manifest').xpath('./item').first) }

      its(:id) { should == 'item1' }
      its(:href) { should == 'pgepub.css' }
      its(:media_type) { should == 'text/css' }
    end

    describe '#to_hash' do
      context 'keys' do
        subject { EPUBInfo::Models::ManifestItem.new(Nokogiri::XML(File.new('spec/support/xml/metamorphosis_metadata_epub2.opf')).remove_namespaces!.css('manifest').xpath('./item').first).to_hash.keys }
        it { should include :id }
        it { should include :href }
        it { should include :media_type }
      end
    end
  end

  context 'EPUB3' do
    describe '#initialize' do
      subject { EPUBInfo::Models::ManifestItem.new(Nokogiri::XML(File.new('spec/support/xml/wasteland_metadata_epub3.opf')).remove_namespaces!.css('manifest').xpath('./item').first) }

      its(:id) { should == 't1' }
      its(:href) { should == 'wasteland-content.xhtml' }
      its(:media_type) { should == 'application/xhtml+xml' }
    end

    describe '#to_hash' do
      context 'keys' do
        subject { EPUBInfo::Models::ManifestItem.new(Nokogiri::XML(File.new('spec/support/xml/wasteland_metadata_epub3.opf')).remove_namespaces!.css('manifest').xpath('./item').first).to_hash.keys }
        it { should include :id }
        it { should include :href }
        it { should include :media_type }
      end
    end
  end

end