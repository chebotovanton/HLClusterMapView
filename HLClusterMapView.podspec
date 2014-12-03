Pod::Spec.new do |s|
  s.name = ‘HLClusterMapView’
  s.version = ‘1.0’
  s.authors = {‘Anton Chebotov’ => ‘chebotov.anton@gmail.com’}
  s.homepage = 'https://github.com/chebotovanton/HLClusterMapView/'
  s.summary = ‘MKMapView with clusterizing’
  s.source = {:git => 'https://github.com/chebotovanton/HLClusterMapView.git', :tag => ‘1.0’}
  s.license = ‘BSD’

  s.requires_arc = true

  s.platform = :ios
  s.ios.deployment_target = ‘7.0’

  s.frameworks = 'CoreLocation’, ‘MapKit’
end