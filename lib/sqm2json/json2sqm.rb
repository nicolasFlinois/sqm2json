module Sqm2Json
  module Reverse

    # Generate a SQM formatted output from given JSON document
    # @param [Hash] json valid JSON document
    # @return [String] SQM document as string
    def to_sqm(json)
      content = ''
      json.each { |k,v|
        content += get_element(k, v, 0)
      }
      content
    end


    # Convert any JSON element to SQM equivalent
    # @param [Object] key of JSON element
    # @param [Object] value of JSON element
    # @param [Integer] level of the element in the whole JSON tree. (root is level 0)
    # @return [String] SQM formatted element
    def get_element(key, value, level)
      content = ''
      level.times { content << "\t"}

      if value.is_a?(::Numeric)
        content << "#{key.to_s}=#{get_numeric(value)};\r\n"
      elsif value.is_a?(::String)
        content << "#{key.to_s}=\"#{value.gsub(/"/, '""').to_s}\";\r\n"
      elsif value.is_a?(::Array)
        content << get_array(key, value, level)
      elsif value.is_a?(::Hash)
        content << "class #{key.to_s}\r\n"
        level.times { content << "\t"}
        content << "{\r\n"
        value.each{ |k,v|
          content << get_element(k, v, level + 1)
        }
        level.times { content << "\t"}
        content << "};\r\n"
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
      content << "#{key.to_s}[]="
      if values[0].is_a?(::Numeric)
        content << '{'
        values.each { |v|
          content << "#{get_numeric(v)},"
        }
        content.chomp!(',')
        content << "};\r\n"
      else
        content << "\r\n"
        level.times { content << "\t"}
        content << "{\r\n"
        values.each { |v|
          (level + 1).times {content << "\t"}
          content << "\"#{v.to_s}\",\r\n"
        }
        content.chomp!(",\r\n")
        content << "\r\n"
        level.times { content << "\t"}
        content << "};\r\n"
      end
      content
    end


    # Convert a JSON numeric value in SQM equivalent
    # @param [Object] value of JSON element
    # @return [String] SQM formatted numeric value
    def get_numeric(value)
      value.to_s.gsub(/(?<val>[0-9\.]+e[-\+]?)(?<exp>[0-9]+)/) { |m|
        arr = m.split(/e/)
        if arr[1][0] =~ /[0-9]/
          "#{arr[0]}e#{arr[1].rjust(3,'0')}"
        else
          "#{arr[0]}e#{arr[1][0]}#{arr[1][1..-1].rjust(3,'0')}"
        end
      }.to_s
    end

  end
end
