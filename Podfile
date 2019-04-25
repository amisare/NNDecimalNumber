platform :ios, '8.0'

inhibit_all_warnings!
use_frameworks!

workspace 'NNDecimalNumber.xcworkspace'

def all_pods
    pod 'NNDecimalNumber', :path => 'NNDecimalNumber.podspec'
end

target :NNDecimalNumberDemo do
    project './NNDecimalNumberDemo/NNDecimalNumberDemo'
    all_pods
end

target :NNDecimalNumber do
  project './NNDecimalNumber/NNDecimalNumber'
end
