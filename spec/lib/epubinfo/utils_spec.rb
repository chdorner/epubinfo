require 'spec_helper'

describe EPUBInfo::Utils do
  describe '#parse_iso_8601_date' do
    it 'parses only year' do
      EPUBInfo::Utils.parse_iso_8601_date('2012').should == Date.new(2012, 1, 1)
    end

    it 'parses only year, and month' do
      EPUBInfo::Utils.parse_iso_8601_date('2012-02').should == Date.new(2012, 2, 1)
    end

    it 'parses year, month, and day' do
      EPUBInfo::Utils.parse_iso_8601_date('2012-02-03').should == Date.new(2012, 2, 3)
    end
  end
end

