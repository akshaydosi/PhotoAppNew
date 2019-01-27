platform :ios, '10.0'

workspace 'PhotoApp'

def shared_pods
    pod 'Alamofire', '~> 4.5'
    pod 'SwiftyJSON'
    #    pod 'AFNetworking', '~> 3.0'
    pod 'TinyConstraints'
    pod 'SDWebImage', '~> 4.0'
    pod 'AlamofireImage', '~> 3.3'
end

target 'PhotoApp' do
    project 'PhotoApp.xcodeproj'
    use_frameworks!
    
    shared_pods
    
    target 'PhotoAppTests' do
        inherit! :search_paths
        # Pods for testing
    end
    
end
