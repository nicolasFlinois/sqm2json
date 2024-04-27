require File.expand_path('../../spec_helper.rb', __FILE__)


describe ::Sqm2Json, '#convert' do

  subject {
    Class.new { include Sqm2Json }.new
  }

  let(:sqmFiles) {
    Dir[File.expand_path('../../data/*/*', __FILE__)]
  }

  it 'should parse all SQM files' do
    sqmFiles.each { |sqmFile|
      puts "Parsing file '#{sqmFile}'"
      expect {
        json = subject.to_json(File.read(sqmFile))

        log_dir = File.join(File.expand_path('../../../log/', __FILE__), File.basename(File.dirname(sqmFile)), 'json')
        FileUtils.mkdir_p(log_dir) unless File.exist?(log_dir)
        json_file_path = File.join log_dir, File.basename(sqmFile)
        File.delete(json_file_path) if File.exist?(json_file_path)
        File.open(json_file_path, 'w+') { |f|
          f.puts JSON.pretty_generate json
        }
      }.to_not raise_exception
    }
  end

end


