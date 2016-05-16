module Sqm2Json

  # Parse a given SQM file to JSON document
  # NOTICE: the implementation is far from being perfect but just works
  # @param [String] sqm_document valid and readable mission.sqm file path
  # @return [Hash] JSON document
  def to_json(sqm_document)
    content = sqm_document.delete("\r\n").delete("\t")

    content.gsub!(/(?<key>\w*)(\s)*=(\s)*(?<val>"");/, '\k<key>="ʉ";') # replace empty string values
    content.gsub!('""', '\"') # 2x" in init fields replaced by \"

    content.gsub!(/(?<key>[\w]+)(\[\])?=(?<val>".{0,}?([^\\]\";))/) { |m|
      pairs = m.split('=')
      puts pairs[1].gsub(/;/,'ʊ').gsub(/,/,'ʎ').chomp('ʊ').gsub('""','\"') if pairs[1].include? '""'
      "\"#{pairs[0]}\": #{pairs[1].gsub(/;/,'ʊ').gsub(/,/,'ʎ').chomp('ʊ').gsub('""','\"')},"
    }

    content.gsub!(/class (?<val>\w+)\s*\{/, '"\k<val>" : {')
    content.gsub!(/(?<key>\w*)=(?<val>[\w#+\-0-9 .,]+);/, '"\k<key>" : \k<val>,')
    content.gsub!(/(?<key>\w*)\[\]\s*=\s*\{(?<val>[\w#\+\-0-9 .,"]+)\};/, '"\k<key>" : [\k<val>],')
    content.gsub!(/\};/, '},')
    content.gsub!(/,\}/, '}')
    content.gsub!(/\}[;,]\}/, '}}')
    content.gsub!(/ʊ/, ';') if content.include? 'ʊ'
    content.gsub!(/ʎ/, ',') if content.include? 'ʎ'
    content.gsub!(/ʉ/, '') if content.include? 'ʉ'
    content = "{#{content.chomp('"').chomp(',')}}"

    ::JSON.parse(content, symbolize_names: true)
  end

end
