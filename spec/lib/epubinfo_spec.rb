require 'spec_helper'

describe EPUBInfo do
  let(:epub_path) { File.expand_path('spec/support/binary/metamorphosis_epub2.epub') }

  describe '#get' do
    it 'calls parser' do
      EPUBInfo::Parser.should_receive(:parse)
      EPUBInfo.get(epub_path)
    end
  end
end

