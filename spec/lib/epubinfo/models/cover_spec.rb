require 'spec_helper'

describe EPUBInfo::Models::Cover do
  describe '#new' do
    context "EPUB2" do
      context "without cover" do
        it "should return nil" do
          path = 'spec/support/binary/nocover_epub2.epub'
          parser = EPUBInfo::Parser.parse(path)
          EPUBInfo::Models::Cover.new(parser).should be_nil
        end
      end

      context "with missing cover image file" do
        it "should return nil" do
          path = 'spec/support/binary/missingcoverfile_epub2.epub'
          parser = EPUBInfo::Parser.parse(path)
          EPUBInfo::Models::Cover.new(parser).should be_nil
        end
      end

      context "with cover" do
        subject do
          path = 'spec/support/binary/metamorphosis_epub2.epub'
          parser = EPUBInfo::Parser.parse(path)
          EPUBInfo::Models::Cover.new(parser)
        end

        its(:content_type) { should == "image/jpeg" }
        its(:original_file_name) { should == "cover.jpg" }

        it "should be correct File" do
          subject.tempfile.should be_kind_of File
          subject.tempfile.size.should == 19263
        end

        it "file should take block" do
          subject.tempfile do |file|
            file.should be_kind_of File
            file.size.should == 19263
          end
        end
      end

      context "with cover in root" do
        subject do
          path = 'spec/support/binary/coverinroot_epub2.epub'
          parser = EPUBInfo::Parser.parse(path)
          EPUBInfo::Models::Cover.new(parser)
        end

        it "should have correct File" do
          subject.tempfile do |file|
            file.should be_kind_of File
            file.size.should == 1908
          end
        end
      end
    end

    context "EPUB3 with cover" do
      subject do
        path = 'spec/support/binary/wasteland_epub3.epub'
        parser = EPUBInfo::Parser.parse(path)
        EPUBInfo::Models::Cover.new(parser)
      end

      its(:content_type) { should == "image/jpeg" }
      its(:original_file_name) { should == "wasteland-cover.jpg" }

      it "file should be correct File" do
        subject.tempfile.should be_kind_of File
        subject.tempfile.size.should == 103477
      end

      it "file should take block" do
        subject.tempfile do |file|
          file.should be_kind_of File
          file.size.should == 103477
        end
      end
    end
  end
end
