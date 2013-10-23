class Resource
  include Enumerable

  def initialize(table_of_contents)
    @table_of_contents = table_of_contents
  end

  def length
    self.count
  end

  def first
    self.to_a.first
  end

  def last
    self.to_a.last
  end

  def [](reference)
    if reference.is_a?(Integer)
      return self.to_a[reference]
    elsif reference.is_a?(Range)
      return self.to_a[reference]
    elsif reference.is_a?(Symbol)
      reference = reference.to_s
    end

    if reference.is_a?(String)
      reference_data = self.to_a.map do |r|
        r[:uri] if r[:id].eql?(reference) || r[:uri].eql?(reference)
      end.compact

      if reference_data && !reference_data.empty?
        return @table_of_contents.parser.zip_file.read(reference_data.first)
      end
    end

    return nil
  end

  def each
    self.to_a.each do |resource|
      yield resource
    end
  end

  def to_a
    @resources ||=
        begin
          resources = []
          @table_of_contents.spine.first.xpath('./itemref').map { |s| s['idref'] }.each do |item_ref|
            resource = @table_of_contents.manifest.css("##{item_ref}").first
            if resource
              uri = resource.attr('href')
              mime_type = resource.attr('media-type')
              label = ''
              uri_ref = ''
              order = ''

              nav_point = @table_of_contents.document.xpath("//navPoint[starts-with(content/@src,'#{uri}')]").first
              if nav_point
                label = nav_point.at('navLabel text').content || ''
                uri_ref = nav_point.at('content').attr('src') || ''
                order = nav_point.attr('playOrder') || ''
              end

              resources << {:id => item_ref,
                            :uri => @table_of_contents.parser.zip_file.entries.map { |p| p.name }.select { |s| s.match(uri) }.first,
                            :uri_ref => uri_ref,
                            :text => label,
                            :type => mime_type,
                            :order => order}
            end
          end
          resources
        end
  end
end