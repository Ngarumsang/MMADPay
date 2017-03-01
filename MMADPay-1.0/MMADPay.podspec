Pod::Spec.new do |s|
  s.name = "MMADPay"
  s.version = "1.0"
  s.summary = "A short description of MMADPay."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Ngarumsang"=>"ngarumsang.v@mmadapps.com"}
  s.homepage = "https://github.com/Ngarumsang/MMADPay"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/MMADPay.framework'
end
