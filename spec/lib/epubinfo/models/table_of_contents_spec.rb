require 'spec_helper'

describe EPUBInfo::Models::TableOfContents do
  describe "#new" do
    context "EPUB2" do
      subject do
        path = 'spec/support/binary/coverinroot_epub2.epub'
        parser = EPUBInfo::Parser.parse(path)
        EPUBInfo::Models::TableOfContents.new(parser)
      end

      it "should have a type" do
        subject.type.should == 'ncx'
      end

      it "should point to the TOC file" do
        subject.path.should == 'epb.ncx'
      end

      it "should be possible to get the raw TOC" do
        subject.document.should be_kind_of Nokogiri::XML::Document
      end

      it "should return the parsed TOC as a list or resources" do
        subject.resources.should be_kind_of Resource
        subject.resources.count.should == 1
        subject.resources.first[:text].should.eql?('Section 1')
      end
    end

    context "EPUB3" do
      subject do
        path = 'spec/support/binary/wasteland_epub3.epub'
        parser = EPUBInfo::Parser.parse(path)
        EPUBInfo::Models::TableOfContents.new(parser)
      end

      it "should have a type" do
        subject.type.should == 'ncx'
      end

      it "should point to the TOC file" do
        subject.path.should == 'EPUB/wasteland.ncx'
      end

      it "should be possible to get the raw TOC" do
        subject.document.should be_kind_of Nokogiri::XML::Document
      end

      it "should return the parsed TOC as a list or resources" do
        subject.resources.should be_kind_of Resource
        subject.resources.count.should == 1
        subject.resources.first[:text].should.eql?('Section 1')
      end

    end
  end
end