Pod::Spec.new do |spec|
  spec.name         = '25519'
  spec.version      = '1.0'
  spec.license      = { :type => 'GPLv3' }
  spec.homepage     = 'https://github.com/FredericJacobs/25519'
  spec.preserve_path = 'Sources/ed25519/**/*.{c,h}'
  spec.authors      = { 'Frederic Jacobs' => 'github@fredericjacobs.com' }
  spec.summary      = 'Objective-C wrapper over Curve25519 & Ed25519 that does signing, verification, key generation, and key agreement with Curve25519 keys.'
  spec.source       = { :git => 'https://github.com/FredericJacobs/25519.git', :tag => '1.0' }
  spec.source_files = 'Classes/*.{h,m}', 'Sources/ed25519/*.{c,h}''Sources/Curve25519/curve25519-donna.c', 'Sources/ed25519/*.{c,h}', 'Sources/ed25519/additions/*.{c,h}', 'Sources/ed25519/sha512/sha2big.{c,h}', 'Sources/ed25519/sha512/sph_sha2.h', 'Sources/ed25519/nacl_includes/*.{c,h}'
  spec.private_header_files = 'Sources/ed25519/*.h', 'Sources/ed25519/nacl_includes/*.h','Sources/ed25519/additions/*.h', 'Sources/ed25519/sha512/*.h'
  spec.framework    = 'Security'
  spec.public_header_files = "Classes/*.h"
  spec.requires_arc = true
end
