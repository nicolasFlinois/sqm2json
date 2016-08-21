require File.expand_path('../../spec_helper.rb', __FILE__)



describe Sqm2Json::Reverse, '#to_sqm' do

  subject {
    Class.new { include Sqm2Json,Sqm2Json::Reverse }.new
  }

  let(:sqmFiles) {
    Dir[File.expand_path('../../data/*/*', __FILE__)]
  }

  it 'should parse then serialize to SQM many mission files without any single change' do
    sqmFiles.each { |sqmFile|
      expect {
        json = subject.to_json(File.read(sqmFile))
        sqm = subject.to_sqm(json)
        generated_file_path = Tempfile.new('mission.sqm')
        File.open(generated_file_path, 'w+') { |f|
          f.puts sqm
        }

        expect(File.read(generated_file_path)).to eq(File.read(sqmFile))
      }.to_not raise_exception
    }
  end
end




describe Sqm2Json::Reverse, '#get_numeric' do

  subject {
    Class.new { include Sqm2Json::Reverse }.new
  }

  it 'should parse integer values' do
    expect(subject.get_numeric('0')).to eq('0')
    expect(subject.get_numeric('-1')).to eq('-1')
    expect(subject.get_numeric('-123456789')).to eq('-123456789')
    expect(subject.get_numeric('+123456789')).to eq('+123456789')
  end


  it 'should parse float values' do
    expect(subject.get_numeric('0.0')).to eq('0.0')
    expect(subject.get_numeric('-0.1')).to eq('-0.1')
    expect(subject.get_numeric('5691.5894')).to eq('5691.5894')
    expect(subject.get_numeric('-0.0055163647')).to eq('-0.0055163647')
  end

  it 'should parse values with exponent' do
    expect(subject.get_numeric(-1.1994416e-0006)).to eq('-1.1994416e-006')
    expect(subject.get_numeric(-1.3831086e-5)).to eq('-1.3831086e-005')
  end

end


describe Sqm2Json::Reverse, '#get_array' do

  subject {
    Class.new { include Sqm2Json::Reverse }.new
  }

  it 'should generate an array of numbers' do
    expect(subject.get_array(:pos, [13244.387,47.59338,6758.1636], 0)).to eq("pos[]={13244.387,47.59338,6758.1636};\r\n")
    expect(subject.get_array(:dir, [-0.13561009,-0.5221594,-0.84213799], 1)).to eq("dir[]={-0.13561009,-0.5221594,-0.84213799};\r\n")
    expect(subject.get_array(:up, [-0.083016329,0.85281855,-0.51553977], 2)).to eq("up[]={-0.083016329,0.85281855,-0.51553977};\r\n")
    expect(subject.get_array(:aside, [-0.98740709,2.7598435e-007,0.15900296], 0)).to eq("aside[]={-0.98740709,2.7598435e-007,0.15900296};\r\n")
    expect(subject.get_array("type", ["BOOL"], 0)).to eq("type[]=\r\n{\r\n\t\"BOOL\"\r\n};\r\n")
    expect(subject.get_array("type", ["BOOL"], 3)).to eq("type[]=\r\n\t\t\t{\r\n\t\t\t\t\"BOOL\"\r\n\t\t\t};\r\n")
  end
end


describe Sqm2Json::Reverse, '#get_element' do

  subject {
    Class.new { include Sqm2Json::Reverse }.new
  }

  it 'should generate any single element' do
    expect(subject.get_element("dataType", "Object", 0)).to eq("dataType=\"Object\";\r\n")
    expect(subject.get_element(:key,['value1', 'value2'], 2)).to eq("\t\tkey[]=\r\n\t\t{\r\n\t\t\t\"value1\",\r\n\t\t\t\"value2\"\r\n\t\t};\r\n")
    expect(subject.get_element("type", ["BOOL"], 3)).to eq("\t\t\ttype[]=\r\n\t\t\t{\r\n\t\t\t\t\"BOOL\"\r\n\t\t\t};\r\n")
    expect(subject.get_element(:nextID,412,2)).to eq("\t\tnextID=412;\r\n")
    expect(subject.get_element(:expression, "if(parseNumber _value >= 0)then{if(parseNumber _value == 0)then{{[_this setobjectTexture [_x,'a3\\data_f\\clear_empty.paa']]}foreach cRHSAIRSU25NumberPlaces}else{[_this, [['Number', cRHSAIRSU25NumberPlaces, _this getVariable ['rhs_decalNumber_type','AviaYellow'],parseNumber _value] ] ] call rhs_fnc_decalsInit}};", 0)).to eq("expression=\"if(parseNumber _value >= 0)then{if(parseNumber _value == 0)then{{[_this setobjectTexture [_x,'a3\\data_f\\clear_empty.paa']]}foreach cRHSAIRSU25NumberPlaces}else{[_this, [['Number', cRHSAIRSU25NumberPlaces, _this getVariable ['rhs_decalNumber_type','AviaYellow'],parseNumber _value] ] ] call rhs_fnc_decalsInit}};\";\r\n")
    expect(subject.get_element("EditorData",{
        "moveGridStep": 1,
        "angleGridStep": 0.2617994,
        "scaleGridStep": 1,
        "autoGroupingDist": 10,
        "toggles": 137,
        "ItemIDProvider": {
            "nextID": 1457
        },
        "MarkerIDProvider": {
            "nextID": 412
        },
        "Camera": {
            "pos": [
                13244.387,
                47.59338,
                6758.1636
            ],
            "dir": [
                -0.13561009,
                -0.5221594,
                -0.84213799
            ],
            "up": [
                -0.083016329,
                0.85281855,
                -0.51553977
            ],
            "aside": [
                -0.98740709,
                2.7598435e-07,
                0.15900296
            ]
        }
    }, 1)).to eq("\tclass EditorData\r\n\t{\r\n\t\tmoveGridStep=1;\r\n\t\tangleGridStep=0.2617994;\r\n\t\tscaleGridStep=1;\r\n\t\tautoGroupingDist=10;\r\n\t\ttoggles=137;\r\n\t\tclass ItemIDProvider\r\n\t\t{\r\n\t\t\tnextID=1457;\r\n\t\t};\r\n\t\tclass MarkerIDProvider\r\n\t\t{\r\n\t\t\tnextID=412;\r\n\t\t};\r\n\t\tclass Camera\r\n\t\t{\r\n\t\t\tpos[]={13244.387,47.59338,6758.1636};\r\n\t\t\tdir[]={-0.13561009,-0.5221594,-0.84213799};\r\n\t\t\tup[]={-0.083016329,0.85281855,-0.51553977};\r\n\t\t\taside[]={-0.98740709,2.7598435e-007,0.15900296};\r\n\t\t};\r\n\t};\r\n")
  end

end

