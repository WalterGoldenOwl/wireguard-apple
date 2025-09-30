// SPDX-License-Identifier: MIT
// Swift fallback declarations for Go bridge symbols when the Clang module is unavailable.

#if canImport(WireGuardKitGo)
import WireGuardKitGo
#else
import Darwin

typealias WireGuardLoggerFn = @convention(c) (UnsafeMutableRawPointer?, Int32, UnsafePointer<CChar>?) -> Void

@_silgen_name("wgSetLogger")
func wgSetLogger(_ context: UnsafeMutableRawPointer?, _ logger: WireGuardLoggerFn?)

@_silgen_name("wgTurnOn")
func wgTurnOn(_ settings: UnsafePointer<CChar>?, _ tunFD: Int32) -> Int32

@_silgen_name("wgTurnOff")
func wgTurnOff(_ handle: Int32)

@_silgen_name("wgSetConfig")
func wgSetConfig(_ handle: Int32, _ settings: UnsafePointer<CChar>?) -> Int64

@_silgen_name("wgGetConfig")
func wgGetConfig(_ handle: Int32) -> UnsafeMutablePointer<CChar>?

@_silgen_name("wgBumpSockets")
func wgBumpSockets(_ handle: Int32)

@_silgen_name("wgDisableSomeRoamingForBrokenMobileSemantics")
func wgDisableSomeRoamingForBrokenMobileSemantics(_ handle: Int32)

@_silgen_name("wgVersion")
func wgVersion() -> UnsafePointer<CChar>?
#endif
