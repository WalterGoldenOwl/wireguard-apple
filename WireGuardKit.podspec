Pod::Spec.new do |s|
  s.name         = 'WireGuardKit'
  s.version      = '1.0.0'
  s.summary      = 'Unified WireGuard Apple Kit'
  s.description  = 'WireGuard Apple implementation split into subspecs.'
  s.homepage     = 'https://www.wireguard.com'
  s.license      = { :type => 'MIT', :file => 'COPYING' }
  s.author       = { 'WireGuard' => 'team@wireguard.com' }

  s.platform     = :ios, '15.0'
  s.swift_version = '5.0'
  s.requires_arc = true

  s.source = { :git => 'https://github.com/WalterGoldenOwl/wireguard-apple.git', :branch => 'master' }

  # Subspec cho từng module con
  s.subspec 'WireGuardKit' do |kit|
    kit.source_files = 'Sources/WireGuardKit/**/*.{swift,h,m,c}'
    kit.public_header_files = 'Sources/WireGuardKit/**/*.h'
  end

  s.subspec 'WireGuardKitC' do |kitc|
    kitc.source_files = 'Sources/WireGuardKitC/**/*.{c,h}'
    kitc.public_header_files = 'Sources/WireGuardKitC/**/*.h'
  end

  s.subspec 'WireGuardKitGo' do |go|
    go.source_files = 'Sources/WireGuardKitGo/**/*.{swift,h,m}'
    go.public_header_files = 'Sources/WireGuardKitGo/**/*.h'
  end

  s.subspec 'Shared' do |shared|
    shared.source_files = 'Sources/Shared/**/*.{swift,h,m}'
    shared.public_header_files = 'Sources/Shared/**/*.h'
  end

  s.subspec 'WireGuardApp' do |app|
    app.source_files = 'Sources/WireGuardApp/**/*.{swift,h,m}'
  end

  s.subspec 'WireGuardNetworkExtension' do |ne|
    ne.source_files = 'Sources/WireGuardNetworkExtension/**/*.{swift,h,m}'
  end
end
