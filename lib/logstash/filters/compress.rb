# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

require "zlib"
require "base64"

# This  filter will replace the contents of the default 
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an .
class LogStash::Filters::Compress < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   compress {
  #     fields => ...
  #   }
  # }
  #
  config_name "compress"

  # The fields to be compressed
  config :fields, :validate => :array, :required => true  

  public
  def register
    # Add instance variables 
  end # def register

  public
  def filter(event)

    @fields.each do |field|
      next unless event.include?(field)
      if event.get(field).is_a?(Array)
        event.set(field, event.get(field).collect { |v| compress(v) })
      else
        event.set(field, compress(event.get(field)))
      end
    end
  end # def filter

  private
  def compress(data)
    Base64.encode64(Zlib::Deflate.deflate(data)
  end

end # class LogStash::Filters::Compress
