platform :ios, '8.0'

use_frameworks!

workspace 'NNDecimalNumber.xcworkspace'

def all_pods
    pod 'NNDecimalNumber', :path => 'NNDecimalNumber.podspec'
end

target :NNDecimalNumberDemo do
    project './Example/NNDecimalNumberDemo'
    all_pods
end
