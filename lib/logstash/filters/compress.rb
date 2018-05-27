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
  #    {
  #   }
  # }
  #
  config_name "compress"
  
  
  config :message, :validate => :string
  

  public
  def register
    # Add instance variables 
  end # def register

  public
  def filter(event)

    if @message
      # Replace the event message with our message as configured in the
      # config file.
      # compress zlib and encode base64
      event.set("message", Base64.encode64(Zlib::Deflate.deflate(@message)))
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Compress
