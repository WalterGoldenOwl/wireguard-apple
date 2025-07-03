Pod::Spec.new do |s|
  s.name             = 'WireGuardKit'
  s.version          = '1.0.0'
  s.summary          = 'WireGuard implementation for iOS'
  s.homepage         = 'https://github.com/your-repo'
  s.license          = { :type => 'MIT', :file => 'COPYING' }
  s.author           = { 'Your Name' => 'your@email.com' }
  s.source           = { :git => 'https://github.com/WalterGoldenOwl/wireguard-apple.git', :branch => 'master' }
  
  s.ios.deployment_target = '15.0'
  s.swift_version    = '5.0'
  
  # Thiết lập cấu trúc thư mục chính
  s.header_dir = 'WireGuardKit'
  s.source_files = 'Sources/**/*.{swift,h,m,c}'
  s.preserve_paths = [
    'sync-translations.sh',
    'WireGuard.xcodeproj',
    'WireGuard.xcodeproj/**/*',
    '.swiftlint.yml',
    'README.md',
    'COPYING',
    '.gitignore',
    'Package.swift',
    'Sources/**/*',
    'MOBILECONFIG.md'
  ]

  # Phần C
  s.subspec 'WireGuardKitC' do |c|
    c.source_files = 'Sources/WireGuardKitC/**/*.{c,h}'
    c.public_header_files = 'Sources/WireGuardKitC/**/*.h'
    c.private_header_files = 'Sources/WireGuardKitC/**/*.h'
  end

  # Phần Swift
  s.subspec 'WireGuardKit' do |swift|
    swift.source_files = 'Sources/WireGuardKit/**/*.swift'
    swift.dependency 'WireGuardKit/WireGuardKitC'
  end

  # Phần Go
  s.subspec 'WireGuardKitGo' do |go|
    go.source_files = 'Sources/WireGuardKitGo/**/*.{swift,h,m}'
    go.dependency 'WireGuardKit/WireGuardKitC'
  end

  # Thiết lập mặc định
  s.default_subspecs = 'WireGuardKitC', 'WireGuardKit', 'WireGuardKitGo'
end