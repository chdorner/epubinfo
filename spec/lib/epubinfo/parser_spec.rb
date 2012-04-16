require 'spec_helper'

describe EPUBInfo::Parser do
  let(:epub_path) { File.expand_path('spec/support/binary/metamorphosis_epub2.epub') }
  subject { EPUBInfo::Parser.parse(epub_path) }

  it 'should expose the path' do
    subject.path.should == epub_path
  end

  it 'should expose the correct metadata document' do
    subject.metadata_document.should be_kind_of Nokogiri::XML::Document
    id_node = subject.metadata_document.xpath('//dc:identifier').first
    id_node.content.should == 'http://www.gutenberg.org/ebooks/5200'
  end

  it 'should return true for drm protected files' do
    drm_path = 'spec/support/binary/metamorphosis_epub2_drm.epub'
    parser = EPUBInfo::Parser.parse(drm_path)
    parser.drm_protected?.should be_true
  end

  it 'should return false for non-drm protected files' do
    non_drm_path = 'spec/support/binary/metamorphosis_epub2.epub'
    parser = EPUBInfo::Parser.parse(non_drm_path)
    parser.drm_protected?.should be_false
  end
end

