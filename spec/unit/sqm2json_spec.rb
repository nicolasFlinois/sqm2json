require File.expand_path('../../spec_helper.rb', __FILE__)

describe ::Sqm2Json, '#convert' do

  subject do
    Class.new { include Sqm2Json }.new
  end

  let(:sqm_files) do
    Dir[File.expand_path("../../data/#{SQM_VERSIONS_TO_VALIDATE}/*", __FILE__)]
  end

  it 'should parse all SQM files' do
    sqm_files.each do |sqm_file|
      puts "Parsing file '#{sqm_file}'"
      expect do
        json = subject.to_json(File.read(sqm_file))

        log_dir = File.join(File.expand_path('../../../log/', __FILE__), File.basename(File.dirname(sqm_file)), 'json')
        FileUtils.mkdir_p(log_dir) unless File.exist?(log_dir)
        json_file_path = File.join log_dir, File.basename(sqm_file)
        File.delete(json_file_path) if File.exist?(json_file_path)
        File.open(json_file_path, 'w+') { |f|
          f.puts JSON.pretty_generate json
        }
        begin
          JSON.load_file(json_file_path)
        rescue StandardError
          raise "invalid JSON file #{json_file_path}"
        end
      end.to_not raise_exception
    end
  end

end
