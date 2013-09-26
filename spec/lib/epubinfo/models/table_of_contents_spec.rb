require 'spec_helper'

describe EPUBInfo::Models::TableOfContents do
  describe "#new" do
    context "EPUB2" do
      subject do
        path = 'spec/support/binary/coverinroot_epub2.epub'
        parser = EPUBInfo::Parser.parse(path)
        EPUBInfo::Models::TableOfContents.new(parser)
      end



    end
  end
end