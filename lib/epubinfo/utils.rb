module EPUBInfo
  module Utils
    def self.parse_iso_8601_date(date_str)
      case date_str.count('-')
      when 0
        Date.strptime(date_str, '%Y')
      when 1
        Date.strptime(date_str, '%Y-%m')
      when 2
        Date.strptime(date_str, '%Y-%m-%d')
      end
    end
  end

  class NotAnEPUBFileError < StandardError; end
end

