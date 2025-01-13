# Provide SQM =>> JSON conversion
module Sqm2Json

  # Parse a given SQM file to JSON document
  # NOTICE: the implementation is far from being perfect but just works
  # @param [String] sqm_document valid and readable mission.sqm file path
  # @return [Hash] JSON document
  def to_json(sqm_document)
    content = sqm_document.delete("\r\n").delete("\t")
    content.gsub!(/(?<key>\w*)\s*=\s*(?<val>"");/, '\k<key>="ʉ";') # replace empty string values
    protect_special_chars_into_values(content)
    content.gsub!(/class (?<val>\w+)\s*\{/, '"\k<val>" : {')
    content.gsub!(/(?<key>\w*)=(?<val>[\w#+\-0-9 .,]+);/, '"\k<key>" : \k<val>,')
    content.gsub!(/(?<key>\w*)\[\]\s*=\s*\{(?<val>[\w#\+\-0-9 .,"]+)\};/, '"\k<key>" : [\k<val>],')
    content.gsub!(/\};/, '},')
    content.gsub!(/,\}/, '}')
    content.gsub!(/\}[;,]\}/, '}}')
    recover_special_chars_into_values(content)
    ::JSON.parse("{#{content.chomp('"').chomp(',')}}", symbolize_names: true)
  end

  # Replace special characters into init-like fields before processing the structure
  def protect_special_chars_into_values(content)
    content.gsub!(/(\w+)(\[\])?\s*=\s*"(.{0,}?([^\\]))";/) do
      "\"#{$1}\": \"#{$3.gsub(/;/, 'ʊ').gsub(/,/, 'ʎ').gsub('"', 'ƛ').gsub(/'/, 'ɣ').gsub(/\\([^"])/, '\\\\\\\\\1')}\","
    end
  end

  # Recover protected special characters into init-like fields after processing the structure
  def recover_special_chars_into_values(content)
    content.gsub!(/"(\w+)(\[\])?"\s*:\s*"(.{0,}?([^\\])*)"(,)?/) do
      "\"#{$1}\" : \"#{$3.gsub(/ʊ/, ';').gsub(/ʎ/, ',').gsub(/ƛ/, '\"').gsub(/ɣ/, '\'').gsub(/ʉ/, '')}#{$4}\""
    end
  end

end
