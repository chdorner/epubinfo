require 'spec_helper'

describe EPUBInfo::Models::Person do
  describe '#initialize' do
    context 'creator' do
      subject { EPUBInfo::Models::Person.new(Nokogiri::XML(File.new('spec/support/xml/metamorphosis_metadata_epub2.opf')).remove_namespaces!.css('metadata').xpath('.//creator').first) }

      its(:name) { should == 'Franz Kafka' }
      its(:file_as) { should == 'Kafka, Franz' }
      its(:role) { should be_nil }
    end

    context 'contributor' do
      subject { EPUBInfo::Models::Person.new(Nokogiri::XML(File.new('spec/support/xml/metamorphosis_metadata_epub2.opf')).remove_namespaces!.css('metadata').xpath('.//contributor').first) }

      its(:name) { should == 'David Wyllie' }
      its(:file_as) { should == 'Wyllie, David' }
      its(:role) { should == 'trl' }
    end
  end

  describe '#initialize' do
    context 'keys' do
      subject { EPUBInfo::Models::Person.new(Nokogiri::XML(File.new('spec/support/xml/metamorphosis_metadata_epub2.opf')).remove_namespaces!.css('metadata').xpath('.//creator').first).to_hash.keys }
      it { should include :name }
      it { should include :file_as }
      it { should include :role }
    end
  end
end

