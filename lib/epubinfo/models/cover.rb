module EPUBInfo
  module Models
    class Cover
      def self.new(parser)
        return nil unless EPUBInfo::Parser === parser

        cover = super(parser)

        if cover.exists?
          cover
        else
          nil
        end
      end

      def initialize(parser)
        @parser = parser
        @path   = epub_cover_file_path
        @content_type = epub_cover_content_type
      end

      # Original name of cover file
      # @return [String]
      def original_file_name
        File.basename(@path) if @path
      end

      # Content type of cover file
      # @return [String]
      attr_accessor :content_type
      def content_type; @content_type; end

      # Cover exists?
      # @return [Boolean]
      # @!visibility private
      def exists?
        !!@path && @parser.zip_file.find_entry(zip_file_path)
      end

      # Cover file
      # @return [File]
      # Tempfile is used to enable access to cover file
      # If block is passed, the tempfile is passed to it
      #   cover.file do { |f| puts f.size }
      # Otherwise user is responsible to unlink and close tempfile
      #   file = book.cover.file
      #   file.size
      #   file.close!
      def tempfile(&block)
        tempfile = Tempfile.new("epubinfo")
        tempfile.binmode

        cover_file = @parser.zip_file.read(zip_file_path)
        tempfile.write(cover_file)

        if block_given?
          yield tempfile
          tempfile.close!
        else
          # user is responsible for closing file
          tempfile
        end
      end

      private

      def epub_cover_file_path
        epub_cover_item.attr('href') if epub_cover_item
      end

      def epub_cover_content_type
        epub_cover_item.attr('media-type') if epub_cover_item
      end

      def epub_cover_item
        @epub_cover_item ||= begin
          metadata = @parser.metadata_document.css('metadata')
          cover_id = metadata.css('meta [name=cover]').attr("content").value rescue nil || 'cover-image'

          manifest = @parser.metadata_document.css('manifest')

          manifest.css("item [id = #{cover_id}]").first rescue nil ||
            manifest.css("item [property = #{cover_id}]").first rescue nil
        end
      end

      def zip_file_path
        dir = File.dirname(@parser.metadata_path)
        path =
          if dir == '.'
            @path
          else
            File.join(dir, @path)
          end
        CGI::unescape(path)
      end
    end
  end
end
