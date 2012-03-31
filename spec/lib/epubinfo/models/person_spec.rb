require 'spec_helper'

describe EPUBInfo::Models::Person do
  context 'creator' do
    subject { EPUBInfo::Models::Person.new(Nokogiri::XML(File.new('spec/support/xml/metamorphosis_metadata.opf')).css('metadata').xpath('.//dc:creator').first) }

    its(:name) { should == 'Franz Kafka' }
    its(:file_as) { should == 'Kafka, Franz' }
    its(:role) { should be_nil }
  end

  context 'contributor' do
    subject { EPUBInfo::Models::Person.new(Nokogiri::XML(File.new('spec/support/xml/metamorphosis_metadata.opf')).css('metadata').xpath('.//dc:contributor').first) }

    its(:name) { should == 'David Wyllie' }
    its(:file_as) { should == 'Wyllie, David' }
    its(:role) { should == 'trl' }
  end
end

