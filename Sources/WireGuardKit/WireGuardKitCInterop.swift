// SPDX-License-Identifier: MIT
// Swift fallback declarations for C helpers when the Clang module is unavailable.

#if canImport(WireGuardKitC)
import WireGuardKitC
#else
import Darwin

@_silgen_name("curve25519_derive_public_key")
func curve25519_derive_public_key(_ publicKey: UnsafeMutablePointer<UInt8>!, _ privateKey: UnsafePointer<UInt8>!)

@_silgen_name("curve25519_generate_private_key")
func curve25519_generate_private_key(_ privateKey: UnsafeMutablePointer<UInt8>!)

@_silgen_name("key_to_hex")
func key_to_hex(_ hex: UnsafeMutablePointer<CChar>!, _ key: UnsafePointer<UInt8>!)

@_silgen_name("key_from_hex")
func key_from_hex(_ key: UnsafeMutablePointer<UInt8>!, _ hex: UnsafePointer<CChar>!) -> Bool

@_silgen_name("key_to_base64")
func key_to_base64(_ base64: UnsafeMutablePointer<CChar>!, _ key: UnsafePointer<UInt8>!)

@_silgen_name("key_from_base64")
func key_from_base64(_ key: UnsafeMutablePointer<UInt8>!, _ base64: UnsafePointer<CChar>!) -> Bool

@_silgen_name("key_eq")
func key_eq(_ key1: UnsafePointer<UInt8>!, _ key2: UnsafePointer<UInt8>!) -> Bool
#endif
