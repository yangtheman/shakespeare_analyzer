require 'nokogiri'
require 'open-uri'

class XmlParser 
  
  attr_reader :doc, :speech_count
  
  def initialize(url_or_path)
    @doc = Nokogiri::XML(open(url_or_path))
    @speech_count = {}
  end
  
  def count_lines(element)
    node_set = element.xpath(".//LINE")
    node_set.count
  end
  
  def parse_speeches
    @doc.xpath("//SPEECH").each do |speech|
      speaker = speech.xpath(".//SPEAKER").text
      @speech_count[speaker] ||= 0
      @speech_count[speaker] += count_lines(speech)
    end
  end
  
end