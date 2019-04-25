Pod::Spec.new do |s|

    s.name          = "NNDecimalNumber"
    s.version       = "0.0.1"
    s.summary       = "NNDecimalNumber"
  
    s.description   = <<-DESC
                     NNDecimalNumber
                     DESC
  
    s.homepage      = "https://github.com/amisare/NNDecimalNumber"
    s.license       = { :type => "MIT", :file => "LICENSE" }
    s.author        = { "Haijun Gu" => "243297288@qq.com" }
    s.social_media_url        = "http://www.jianshu.com/users/9df9f28ff266/latest_articles"
  
    s.source        = { :git => "https://github.com/amisare/NNDecimalNumber.git", :tag => s.version }
    s.ios.deployment_target   = '8.0'
    s.requires_arc  = true
  
    s.source_files        = 'NNDecimalNumber/NNDecimalNumber/*.{h,m}'
    s.public_header_files = 'NNDecimalNumber/NNDecimalNumber/NNDecimalNumber.h'
  end
  