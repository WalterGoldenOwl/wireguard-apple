Pod::Spec.new do |s|
  s.name             = 'WireGuardKit'
  s.version          = '1.0.0'
  s.summary          = 'Unified WireGuard Apple Kit'
  s.description      = 'WireGuard Apple implementation as a single pod.'
  s.homepage         = 'https://www.wireguard.com'
  s.license          = { :type => 'MIT', :file => 'COPYING' }
  s.author           = { 'WireGuard' => 'team@wireguard.com' }

  s.platform         = :ios, '15.0'
  s.swift_version    = '5.9'
  s.requires_arc     = true

  s.source           = { :git => 'https://github.com/WalterGoldenOwl/wireguard-apple.git', :branch => 'master' }

  s.source_files     = 'Sources/**/*.{swift,h,m,c,cpp}'
  s.public_header_files = 'Sources/**/*.h'

  s.resources        = [
    'Sources/**/*.lproj',
    'Sources/**/*.plist',
    'Sources/**/*.strings',
    'Sources/**/*.entitlements'
  ]

  s.preserve_paths = [
    'Sources/**/*.{go,modulemap,diff,sh,mod,sum,Makefile}'
  ]

  s.module_map = 'Sources/WireGuardKitC/module.modulemap'
end
