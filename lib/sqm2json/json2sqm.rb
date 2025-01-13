
module Sqm2Json
  # Provide JSON => SQM conversion
  module Reverse

    # Generate a SQM formatted output from given JSON document
    # @param [Hash] json valid JSON document
    # @return [String] SQM document as string
    def to_sqm(json)
      content = ''
      json.each { |k, v| content += get_element(k, v, 0) }
      content
    end

    # Convert any JSON element to SQM equivalent
    # @param [Object] key of JSON element
    # @param [Object] value of JSON element
    # @param [Integer] level of the element in the whole JSON tree. (root is level 0)
    # @return [String] SQM formatted element
    def get_element(key, value, level)
      content = ''
      level.times { content << "\t" }

      case value
      when ::Numeric
        content << "#{key}=#{get_numeric(value)};\r\n"
      when ::String
        content << "#{key}=\"#{value}\";\r\n"
      when ::Array
        content << get_array(key, value, level)
      when ::Hash
        content << "class #{key}\r\n"
        level.times { content << "\t" }
        content << "{\r\n"
        value.each { |k, v|
          content << get_element(k, v, level + 1)
        }
        level.times { content << "\t" }
        content << "};\r\n"
      else
        raise "Invalid JSON element type: #{value.class}"
      end
      content
    end

    # Convert a JSON value array in SQM equivalent
    # @param [Object] key of JSON element
    # @param [Array] values of JSON element
    # @param [Integer] level of the element in the whole JSON tree. (root is level 0)
    # @return [String] SQM formatted array
    def get_array(key, values, level)
      content = ''
      content << "#{key}[]="
      if values[0].is_a?(::Numeric)
        content << '{'
        values.each { |v|
          content << "#{get_numeric(v)},"
        }
        content.chomp!(',')
      else
        content << "\r\n"
        level.times { content << "\t" }
        content << "{\r\n"
        values.each do |v|
          (level + 1).times {content << "\t" }
          content << "\"#{v.to_s}\",\r\n"
        end
        content.chomp!(",\r\n")
        content << "\r\n"
        level.times { content << "\t" }
      end
      content << "};\r\n"
      content
    end

    # Convert a JSON numeric value in SQM equivalent
    # @param [Object] value of JSON element
    # @return [String] SQM formatted numeric value
    def get_numeric(value)
      value.to_s.gsub(/(?<val>[0-9\.]+e[-\+]?)(?<exp>[0-9]+)/) do |m|
        arr = m.split(/e/)
        if arr[1][0] =~ /[0-9]/
          "#{arr[0]}e#{arr[1].rjust(3,'0')}"
        else
          "#{arr[0]}e#{arr[1][0]}#{arr[1][1..].rjust(3,'0')}"
        end
      end.to_s
    end

  end
end
