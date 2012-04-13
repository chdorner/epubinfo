require 'spec_helper'

describe EPUBInfo::Parser do
  let(:epub_path) { File.expand_path('spec/support/binary/metamorphosis_epub2.epub') }
  let(:parser) { EPUBInfo::Parser.parse(epub_path) }

  describe '#parse' do
    it 'should assign path to @path' do
      parser # preload to avoid infinite loop
      EPUBInfo::Parser.stub(:new) { parser }
      EPUBInfo::Parser.parse(epub_path)
      parser.path.should == epub_path
    end
  end

  describe '#load_epub' do
    it 'assigns zipfile to @zipfile' do
      parser.send(:load_epub)
      parser.instance_variable_get(:@zipfile).should be_kind_of Zip::ZipFile
    end
  end

  describe '#load_root_file' do
    it 'should assign nokogiri document to @root_document' do
      parser.send(:load_epub)
      parser.send(:load_root_file)
      parser.instance_variable_get(:@root_document).should be_kind_of Nokogiri::XML::Document
    end

    it 'should call load_epub if @zipfile is nil' do
      zipfile = Zip::ZipFile.new(epub_path)
      zipfile.stub(:read) { '' }
      parser.should_receive(:load_epub) { parser.instance_variable_set(:@zipfile, zipfile); nil }
      parser.send(:load_root_file)
    end
  end
  
  describe '#metadata_path' do
    it 'should return path to metadata file' do
      parser.send(:metadata_path).should == '5200/content.opf'
    end

    it 'should call load_root_file if @root_document is nil' do
      xml_document = Nokogiri::XML::Document.new
      xml_document.stub_chain(:css, :attribute, :content)
      parser.should_receive(:load_root_file) { parser.instance_variable_set(:@root_document, xml_document); nil }
      parser.send(:metadata_path)
    end
  end

  describe '#metadata_document' do
    it 'should call load_metadata_file and assign to @metadata_document' do
      parser.should_receive(:load_metadata_file) { 'loaded' }
      parser.metadata_document
      parser.instance_variable_get(:@metadata_document).should == 'loaded'
    end

    it 'should not call load_metadata_file if @metadata_document is not nil' do
      parser.instance_variable_set(:@metadata_document, 'loaded')
      parser.should_not_receive(:load_metadata_file)
      parser.metadata_document
    end
  end

  describe '#drm_protected?' do
    it 'should call load_epub if nil' do
      zipfile_mock = mock(:find_entry => true)
      parser.should_receive(:load_epub) { parser.instance_variable_set(:@zipfile, zipfile_mock); nil }
      parser.drm_protected?
      parser.instance_variable_get(:@zipfile).should == zipfile_mock
    end

    context 'drm' do
      let(:epub_path) { File.expand_path('spec/support/binary/metamorphosis_epub2_drm.epub') }

      it 'should return true if rights.xml exists' do
        parser = EPUBInfo::Parser.parse(epub_path)
        parser.drm_protected?.should be_true
      end
    end

    context 'no drm' do
      let(:epub_path) { File.expand_path('spec/support/binary/metamorphosis_epub2.epub') }

      it 'should return false if rights.xml does not exist' do
        parser = EPUBInfo::Parser.parse(epub_path)
        parser.drm_protected?.should be_false
      end
    end
  end

  describe '#load_metadata_file' do
    it 'should return xml document' do
      parser.send(:load_root_file)
      parser.send(:load_metadata_file).should be_kind_of Nokogiri::XML::Document
    end

    it 'should call load_epub if @zipfile is nil' do
      zipfile = Zip::ZipFile.new(epub_path)
      zipfile.stub(:read) { '' }
      parser.should_receive(:load_epub) { parser.instance_variable_set(:@zipfile, zipfile); nil }

      xml_document = Nokogiri::XML::Document.new
      xml_document.stub_chain(:css, :attribute, :content)
      parser.should_receive(:load_root_file) { parser.instance_variable_set(:@root_document, xml_document); nil }

      parser.send(:load_metadata_file)
    end
  end
end

