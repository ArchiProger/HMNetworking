def shared_pods()
  pod 'Alamofire'
end

abstract_target 'iOS' do 
  target 'HMNetworking iOS' do
    platform :ios, '13.0'
    use_frameworks!    
    
    shared_pods()    
  
    target 'Tests iOS' do
      platform :ios, '13.0'
      use_frameworks!
          
      shared_pods()
    end
  end
end

abstract_target 'MacOS' do 
  target 'HMNetworking MacOS' do
    platform :osx, '10.15'
    use_frameworks!    
    
    shared_pods()    
  
    target 'Tests MacOS' do
      platform :osx, '10.15'
      use_frameworks!
          
      shared_pods()
    end
  end
end

abstract_target 'WatchOS' do 
  target 'HMNetworking WatchOS' do
    platform :watchos, '6.0'
    use_frameworks!    
    
    shared_pods()    
  
    target 'Tests WatchOS' do
      platform :watchos, '6.0'
      use_frameworks!
          
      shared_pods()
    end
  end
end

abstract_target 'tvOS' do 
  target 'HMNetworking tvOS' do
    platform :tvos, '13.0'
    use_frameworks!    
    
    shared_pods()    
  
    target 'Tests tvOS' do
      platform :tvos, '13.0'
      use_frameworks!
          
      shared_pods()
    end
  end
end