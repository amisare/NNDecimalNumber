Pod::Spec.new do |s|

  s.name          = "NNDecimalNumber"
  s.version       = "2.0.1"
  s.summary       = "Implement NSDecimalNumber calculations on NSString, NSNumber Category, simplifying NSDecimalNumber calculations."

  s.description   = <<-DESC
                    Implement NSDecimalNumber calculations on NSString, NSNumber Category, simplifying NSDecimalNumber calculations.
                    DESC

  s.homepage      = "https://github.com/amisare/NNDecimalNumber"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "Haijun Gu" => "243297288@qq.com" }
  s.social_media_url        = "https://www.jianshu.com/u/9df9f28ff266"

  s.source        = { :git => "https://github.com/amisare/NNDecimalNumber.git", :tag => s.version.to_s }
  s.ios.deployment_target   = '7.0'
  s.requires_arc  = true

  s.source_files        = 'NNDecimalNumber/*.{h,m}'
  s.public_header_files = 'NNDecimalNumber/NNDecimalNumber.h'
end
  