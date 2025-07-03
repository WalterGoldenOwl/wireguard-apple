Pod::Spec.new do |spec|
  spec.name         = "WireGuardKit"
  spec.version      = "1.0.0"
  spec.summary      = "WireGuard implementation for iOS"
  spec.description  = <<-DESC
                      WireGuard implementation for iOS with complete project structure preservation.
                      Includes WireGuard protocol implementation, network extension, and shared components.
                      DESC
  
  spec.homepage     = "https://github.com/your-username/wireguard-ios"
  spec.license      = { :type => "MIT", :file => "COPYING" }
  spec.author       = { "Your Name" => "your.email@example.com" }
  
  spec.platform     = :ios, "15.0"
  spec.ios.deployment_target = "15.0"
  
  spec.source = { :git => 'https://github.com/WalterGoldenOwl/wireguard-apple.git', :branch => 'master' }
  
  # Preserve all project structure
  spec.preserve_paths = [
    "Sources/**/*",
    "WireGuard.xcodeproj/**/*",
    "*.md",
    "*.yml",
    "*.sh",
    "*.swift",
    "COPYING",
    ".gitignore"
  ]
  
  # Main WireGuardKit framework
  spec.default_subspec = 'Core'
  
  # Core WireGuardKit subspec
  spec.subspec 'Core' do |core|
    core.source_files = [
      "Sources/WireGuardKit/**/*.{h,m,swift}",
      "Sources/Shared/**/*.{h,m,swift}"
    ]
    
    core.public_header_files = [
      "Sources/WireGuardKit/**/*.h",
      "Sources/Shared/**/*.h"
    ]
    
    core.preserve_paths = [
      "Sources/WireGuardKit/**/*",
      "Sources/Shared/**/*"
    ]
    
    core.frameworks = [
      "Foundation",
      "UIKit",
      "NetworkExtension",
      "Security"
    ]
  end
  
  # WireGuardKitC subspec for C components
  spec.subspec 'WireGuardKitC' do |c_kit|
    c_kit.source_files = [
      "Sources/WireGuardKitC/**/*.{h,c,m}"
    ]
    
    c_kit.public_header_files = [
      "Sources/WireGuardKitC/**/*.h"
    ]
    
    c_kit.preserve_paths = [
      "Sources/WireGuardKitC/**/*"
    ]
    
    c_kit.libraries = ["c++"]
    c_kit.pod_target_xcconfig = {
      'CLANG_CXX_LANGUAGE_STANDARD' => 'c++17',
      'CLANG_CXX_LIBRARY' => 'libc++'
    }
  end
  
  # WireGuardKitGo subspec for Go components
  spec.subspec 'WireGuardKitGo' do |go_kit|
    go_kit.source_files = [
      "Sources/WireGuardKitGo/**/*.{h,m,go}"
    ]
    
    go_kit.public_header_files = [
      "Sources/WireGuardKitGo/**/*.h"
    ]
    
    go_kit.preserve_paths = [
      "Sources/WireGuardKitGo/**/*"
    ]
    
    go_kit.libraries = ["resolv"]
    go_kit.dependency 'WireGuardKit/WireGuardKitC'
  end
  
  # Global configuration
  spec.swift_version = "5.0"
  spec.requires_arc = true
  
  # Build settings to maintain project structure
  spec.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'VALID_ARCHS' => 'arm64 x86_64',
    'SWIFT_VERSION' => '5.0'
  }
  
  # Resources if any
  spec.resource_bundles = {
    'WireGuardKit' => [
      'Sources/**/*.{storyboard,xib,xcassets,strings,plist}'
    ]
  }
  
  # Additional files to preserve
  spec.prepare_command = <<-CMD
    echo "Preparing WireGuardKit pod..."
    # Run any setup scripts if needed
    if [ -f "sync-translations.sh" ]; then
      chmod +x sync-translations.sh
    fi
  CMD
end