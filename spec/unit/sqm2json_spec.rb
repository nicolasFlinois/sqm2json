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
      expect {  subject.to_json(File.read(sqmFile))  }.to_not raise_exception
    }
  end

end


