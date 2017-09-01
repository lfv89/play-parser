module Playparser
  module Config
    def configs
      structer.new({
        url: "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml",
        speaker_exception: "ALL"
      })
    end

    def configure_http_dependence
      file_getter.dependence = OpenURI
      file_getter.dependence_method = :open
    end

    def configure_parse_dependence
      file_parser.dependence = Nokogiri::XML
      file_parser.dependence_method = :parse
    end

    private

    def structer
      OpenStruct
    end

    def file_getter
      FileGetter
    end

    def file_parser
      FileParser
    end
  end
end

