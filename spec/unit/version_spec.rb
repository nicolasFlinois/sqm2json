require File.expand_path('../../spec_helper.rb', __FILE__)



describe 'Sqm2Json::get_supported_versions' do

  it 'should return the currently supported SQM format versions inside an array' do
    expect(Sqm2Json::get_supported_versions).to be_a(Array)
    expect(Sqm2Json::get_supported_versions).to eq([12,51,52,54])
  end

end

describe 'Sqm2Json::is_version_supported?' do

  it 'should return yes for supported versions' do
    expect(Sqm2Json::is_version_supported?(12)).to be_truthy
    expect(Sqm2Json::is_version_supported?(51)).to be_truthy
    expect(Sqm2Json::is_version_supported?(52)).to be_truthy
    expect(Sqm2Json::is_version_supported?(54)).to be_truthy
  end

  it 'should return no for unsupported versions' do
    expect(Sqm2Json::is_version_supported?(11)).to be_falsey
    expect(Sqm2Json::is_version_supported?(13)).to be_falsey
    expect(Sqm2Json::is_version_supported?(50)).to be_falsey
    expect(Sqm2Json::is_version_supported?(53)).to be_falsey
  end

end

