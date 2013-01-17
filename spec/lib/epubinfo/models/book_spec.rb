require 'spec_helper'

describe EPUBInfo::Models::Book do
  describe '#initialize' do
    context 'EPUB2' do
      subject do
        parser = EPUBInfo::Parser.parse('spec/support/binary/metamorphosis_epub2.epub')
        EPUBInfo::Models::Book.new(parser)
      end

      its(:titles) { should == ['Metamorphosis'] }
      its(:subjects) { should == ['Psychological fiction', 'Metamorphosis -- Fiction'] }
      its(:description) { should == 'Classic story of self-discovery, told in a unique manner by Kafka.' }
      its(:publisher) { should == 'Random House' }
      its(:source) { should == 'http://www.gutenberg.org/files/5200/5200-h/5200-h.htm' }
      its(:languages) { should == ['en'] }
      its(:rights) { should == 'Copyrighted. Read the copyright notice inside this book for details.' }
      its(:drm_protected?) { should be_false }
      its(:cover) { should be_kind_of EPUBInfo::Models::Cover }
      its(:version) { should == '2.0' }

      context 'creators' do
        it 'count is 1' do
          subject.creators.count.should == 1
        end

        it 'values are of type Person' do
          subject.creators.each do |creator|
            creator.should be_kind_of EPUBInfo::Models::Person
          end
        end
      end

      context 'contributors' do
        it 'count is 1' do
          subject.contributors.count.should == 1
        end

        it 'values are of type Person' do
          subject.contributors.each do |contributor|
            contributor.should be_kind_of EPUBInfo::Models::Person
          end
        end
      end

      context 'dates' do
        it 'count is 2' do
          subject.dates.count.should == 2
        end

        it 'values are of type Date' do
          subject.dates.each do |date|
            date.should be_kind_of EPUBInfo::Models::Date
          end
        end
      end

      context 'identifiers' do
        it 'count is 1' do
          subject.identifiers.count.should == 1
        end

        it 'values are of type Identifier' do
          subject.identifiers.each do |identifier|
            identifier.should be_kind_of EPUBInfo::Models::Identifier
          end
        end
      end
    end

    context 'EPUB3' do
      subject do
        parser = EPUBInfo::Parser.parse('spec/support/binary/wasteland_epub3.epub')
        EPUBInfo::Models::Book.new(parser)
      end

      its(:titles) { should == ['The Waste Land'] }
      its(:subjects) { should == ['Fiction'] }
      its(:description) { should == 'Each facsimile page of the original manuscript is accompanied here by a typeset transcript on the facing page' }
      its(:publisher) { should == 'Some Publisher' }
      its(:source) { should == 'http://code.google.com/p/epub-samples/downloads/detail?name=wasteland-20120118.epub' }
      its(:languages) { should == ['en-US'] }
      its(:rights) { should == 'This work is shared with the public using the Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) license.' }
      its(:cover) { should be_kind_of EPUBInfo::Models::Cover }
      its(:version) { should == '3.0' }

      context 'creators' do
        it 'count is 1' do
          subject.creators.count.should == 1
        end

        it 'values are of type Person' do
          subject.creators.each do |creator|
            creator.should be_kind_of EPUBInfo::Models::Person
          end
        end
      end

      context 'contributors' do
        it 'count is 0' do
          subject.contributors.count.should == 0
        end
      end

      context 'dates' do
        it 'count is 2' do
          subject.dates.count.should == 2
        end
      end

      context 'identifiers' do
        it 'count is 1' do
          subject.identifiers.count.should == 1
        end

        it 'values are of type Identifier' do
          subject.identifiers.each do |identifier|
            identifier.should be_kind_of EPUBInfo::Models::Identifier
          end
        end
      end
    end
  end

  context 'default values' do
    subject { EPUBInfo::Models::Book.new(stub(:metadata_document => nil)) }

    its(:titles) { should == [] }
    its(:creators) { should == [] }
    its(:subjects) { should == [] }
    its(:contributors) { should == [] }
    its(:dates) { should == [] }
    its(:identifiers) { should == [] }
    its(:languages) { should == [] }
    its(:cover) { should be_nil }
  end

  describe '#to_hash' do
    context 'keys' do
      subject { EPUBInfo::Models::Book.new(EPUBInfo::Parser.parse('spec/support/binary/metamorphosis_epub2.epub')).to_hash.keys }
      it { should include :titles }
      it { should include :creators }
      it { should include :subjects }
      it { should include :description }
      it { should include :publisher }
      it { should include :contributors }
      it { should include :dates }
      it { should include :identifiers }
      it { should include :source }
      it { should include :languages }
      it { should include :rights }
      it { should include :cover }
    end
  end
end

