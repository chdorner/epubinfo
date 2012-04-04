require 'spec_helper'

describe EPUBInfo do
  let(:epub_path) { File.expand_path('spec/support/binary/metamorphosis_epub2.epub') }

  describe '#get' do
    it 'calls parser' do
      document = EPUBInfo::Parser.parse(epub_path).metadata_document
      parser = mock
      parser.stub(:metadata_document)
      EPUBInfo::Parser.should_receive(:parse) { parser }
      EPUBInfo.get(epub_path)
    end

    it 'instanstiates a book model and returns it' do
      book_mock = mock
      EPUBInfo::Models::Book.should_receive(:new) { book_mock }
      EPUBInfo.get(epub_path).should == book_mock
    end
  end
end

