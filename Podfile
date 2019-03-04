platform :ios, '10.0'

workspace 'PhotoApp'

def shared_pods

pod 'Alamofire', '~> 4.5'
pod 'SwiftLint'
pod 'SDWebImage', '~> 4.0'
pod 'AlamofireImage', '~> 3.3'
pod 'TinyConstraints'
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

target 'PhotoApp(QA)' do
    project 'PhotoApp.xcodeproj'
    use_frameworks!
    
    shared_pods
end

target 'PhotoApp(Prod)' do
    project 'PhotoApp.xcodeproj'
    use_frameworks!
    
    shared_pods
end

