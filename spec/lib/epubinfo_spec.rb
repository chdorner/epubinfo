require 'spec_helper'

describe EPUBInfo do
  let(:epub_path) { File.expand_path('spec/support/binary/metamorphosis.epub') }
  let(:epubinfo) { EPUBInfo.parse(epub_path) }

  describe '#parse' do
    it 'should assign path to @path' do
      epubinfo # preload to avoid infinite loop
      EPUBInfo.stub(:new) { epubinfo }
      EPUBInfo.parse(epub_path)
      epubinfo.path.should == epub_path
    end
  end

  describe '#load_epub' do
    it 'assigns zipfile to @zipfile' do
      epubinfo.send(:load_epub)
      epubinfo.instance_variable_get(:@zipfile).should be_kind_of Zip::ZipFile
    end
  end

  describe '#load_root_file' do
    it 'should assign nokogiri document to @root_document' do
      epubinfo.send(:load_epub)
      epubinfo.send(:load_root_file)
      epubinfo.instance_variable_get(:@root_document).should be_kind_of Nokogiri::XML::Document
    end

    it 'should call load_epub if @zipfile is nil' do
      zipfile = Zip::ZipFile.new(epub_path)
      zipfile.stub(:read) { '' }
      epubinfo.should_receive(:load_epub) { epubinfo.instance_variable_set(:@zipfile, zipfile); nil }
      epubinfo.send(:load_root_file)
    end
  end
  
  describe '#metadata_path' do
    it 'should return path to metadata file' do
      epubinfo.send(:metadata_path).should == '5200/content.opf'
    end

    it 'should call load_root_file if @root_document is nil' do
      xml_document = Nokogiri::XML::Document.new
      xml_document.stub_chain(:css, :attribute, :content)
      epubinfo.should_receive(:load_root_file) { epubinfo.instance_variable_set(:@root_document, xml_document); nil }
      epubinfo.send(:metadata_path)
    end
  end

  describe '#load_metadata_file' do
    it 'should assign nokogiri document to @metadata_document' do
      epubinfo.send(:load_root_file)
      epubinfo.send(:load_metadata_file)
      epubinfo.instance_variable_get(:@metadata_document).should be_kind_of Nokogiri::XML::Document
    end

    it 'should call load_epub if @zipfile is nil' do
      zipfile = Zip::ZipFile.new(epub_path)
      zipfile.stub(:read) { '' }
      epubinfo.should_receive(:load_epub) { epubinfo.instance_variable_set(:@zipfile, zipfile); nil }

      xml_document = Nokogiri::XML::Document.new
      xml_document.stub_chain(:css, :attribute, :content)
      epubinfo.should_receive(:load_root_file) { epubinfo.instance_variable_set(:@root_document, xml_document); nil }

      epubinfo.send(:load_metadata_file)
    end
  end
end

