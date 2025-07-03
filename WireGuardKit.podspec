Pod::Spec.new do |s|
  s.name             = 'WireGuardKit'
  s.version          = '1.0.0' # Cập nhật version phù hợp
  s.summary          = 'WireGuard implementation for iOS'
  s.homepage         = 'https://github.com/WalterGoldenOwl/wireguard-apple.git'
  s.license          = { :type => 'MIT', :file => 'COPYING' }
  s.author           = { 'Your Name' => 'your@email.com' }
  s.source = { :git => 'https://github.com/WalterGoldenOwl/wireguard-apple.git', :branch => 'master' }
  
  s.ios.deployment_target = '15.0'
  s.swift_version    = '5.0'

  # Subspec chính bao gồm tất cả thành phần
  s.default_subspec = 'Main'

  # Subspec cho phần C code
  s.subspec 'WireGuardKitC' do |c|
    c.source_files = 'Sources/WireGuardKitC/**/*.{c,h}'
    c.public_header_files = 'Sources/WireGuardKitC/**/*.h'
    c.preserve_paths = 'Sources/WireGuardKitC/**/*'
  end

  # Subspec cho phần Swift code
  s.subspec 'WireGuardKit' do |swift|
    swift.source_files = 'Sources/WireGuardKit/**/*.swift'
    swift.dependency 'WireGuardKit/WireGuardKitC'
    swift.preserve_paths = 'Sources/WireGuardKit/**/*'
  end

  # Subspec cho phần Go code
  s.subspec 'WireGuardKitGo' do |go|
    go.source_files = 'Sources/WireGuardKitGo/**/*.{swift,h,m}'
    go.preserve_paths = 'Sources/WireGuardKitGo/**/*'
    go.dependency 'WireGuardKit/WireGuardKitC'
  end

  # Subspec tổng hợp
  s.subspec 'Main' do |m|
    m.dependency 'WireGuardKit/WireGuardKitC'
    m.dependency 'WireGuardKit/WireGuardKit'
    m.dependency 'WireGuardKit/WireGuardKitGo'
  end

  # Giữ nguyên các file cấu trúc dự án
  s.preserve_paths = [
    'WireGuard.xcodeproj',
    'WireGuard.xcodeproj/**/*',
    '.swiftlint.yml',
    'README.md',
    'MOBILECONFIG.md',
    'Package.swift',
    'sync-translations.sh'
  ]
end