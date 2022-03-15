//
//  ValueProtocol.swift
//  
//
//  Created by Christopher Richez on 2/6/22.
//

/// A value that can be encoded into a BSON document.
public protocol ValueProtocol {
    /// The BSON type byte to attach to the key associated with this value.
    var type: CollectionOfOne<UInt8> { get }

    var bsonEncoded: [UInt8] { get }
}

extension Int32: ValueProtocol {
    public var bsonEncoded: [UInt8] {
        withUnsafeBytes(of: self) { bytes in
            Array(bytes)
        }
    }

    public var type: CollectionOfOne<UInt8> { CollectionOfOne(0x10) }
}

extension String: ValueProtocol {
    public var bsonEncoded: [UInt8] {
        let content = Array(utf8) + [0]
        guard let size = Int32(exactly: content.count + 1)?.bsonEncoded else {
            fatalError("string too long")
        }
        return size + content
    }

    public var type: CollectionOfOne<UInt8> { CollectionOfOne(0x02) }
}

extension Bool: ValueProtocol {
    public var bsonEncoded: [UInt8] {
        self ? [1] : [0]
    }
    
    public var type: CollectionOfOne<UInt8> { CollectionOfOne(0x08) }
}

extension Int64: ValueProtocol {
    public var bsonEncoded: [UInt8] {
        withUnsafeBytes(of: self) { bytes in
            Array(bytes)
        }
    }
    
    public var type: CollectionOfOne<UInt8> { CollectionOfOne(0x12) }
}

extension UInt64: ValueProtocol {
    public var bsonEncoded: [UInt8] {
        withUnsafeBytes(of: self) { bytes in
            Array(bytes)
        }
    }
    
    public var type: CollectionOfOne<UInt8> { CollectionOfOne(0x11) }
}

extension Double: ValueProtocol {
    public var bsonEncoded: [UInt8] {
        withUnsafeBytes(of: bitPattern) { bytes in
            Array(bytes)
        }
    }
    
    public var type: CollectionOfOne<UInt8> { CollectionOfOne(0x01) }
}

extension Optional: ValueProtocol where Wrapped : ValueProtocol {
    public var bsonEncoded: [UInt8] {
        switch self {
        case .some(let value):
            return value.bsonEncoded
        case .none:
            return []
        }
    }

    public var type: CollectionOfOne<UInt8> {
        switch self {
        case .some(let value):
            return value.type
        case .none:
            return CollectionOfOne(0x0A)
        }
    }
}