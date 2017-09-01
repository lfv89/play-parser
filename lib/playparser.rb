require "nokogiri"
require "ostruct"

require "playparser/config"
require "playparser/version"

require "playparser/services/file_getter"
require "playparser/services/file_parser"
require "playparser/services/line_aggregator"

require "playparser/services/builders/base_builder"
require "playparser/services/builders/acts_builder"
require "playparser/services/builders/lines_builder"
require "playparser/services/builders/play_builder"
require "playparser/services/builders/scenes_builder"
require "playparser/services/builders/speeches_builder"
require "playparser/services/builders/speaker_builder"
require "playparser/services/outputter"

require "playparser/models/concerns/line_aggregatable"
require "playparser/models/play"
require "playparser/models/act"
require "playparser/models/scene"
require "playparser/models/speech"
require "playparser/models/speaker"
require "playparser/models/line"

module Playparser
  extend Playparser::Config

  class << self
    def config
      configure_http_dependence
      configure_parse_dependence
    end

    def execute
      play = (PlayBuilder.new(FileParser.new(FileGetter.new(configs.url).content).content).build).play
      Outputter.new(play.speakers_with_line_counts(except: configs.speaker_exception)).execute
    end
  end
end
