//
//  ValueProtocol.swift
//  
//
//  Created by Christopher Richez on 2/6/22.
//

/// A value that can be assigned to a ``Pair`` in a BSON document.
public protocol ValueProtocol {
    /// The BSON type byte for this type.
    var bsonType: UInt8 { get }
    
    /// This value's BSON-encoded bytes.
    var bsonBytes: [UInt8] { get }
}

extension Int32: ValueProtocol {
    public var bsonBytes: [UInt8] {
        withUnsafeBytes(of: self) { bytes in
            Array(bytes)
        }
    }

    public var bsonType: UInt8 {
        0x10
    }
}

extension String: ValueProtocol {
    public var bsonBytes: [UInt8] {
        let content = Array(utf8) + [0]
        guard let size = Int32(exactly: content.count)?.bsonBytes else {
            fatalError("string too long")
        }
        return size + content
    }

    public var bsonType: UInt8 {
        0x02
    }
}

extension Bool: ValueProtocol {
    public var bsonBytes: [UInt8] {
        self ? [1] : [0]
    }
    
    public var bsonType: UInt8 {
        0x08
    }
}

extension Int64: ValueProtocol {
    public var bsonBytes: [UInt8] {
        withUnsafeBytes(of: self) { bytes in
            Array(bytes)
        }
    }
    
    public var bsonType: UInt8 {
        0x12
    }
}

extension UInt64: ValueProtocol {
    public var bsonBytes: [UInt8] {
        withUnsafeBytes(of: self) { bytes in
            Array(bytes)
        }
    }
    
    public var bsonType: UInt8 {
        0x11
    }
}

extension Double: ValueProtocol {
    public var bsonBytes: [UInt8] {
        withUnsafeBytes(of: bitPattern) { bytes in
            Array(bytes)
        }
    }
    
    public var bsonType: UInt8 {
        0x01
    }
}

extension Optional: ValueProtocol where Wrapped : ValueProtocol {
    public var bsonBytes: [UInt8] {
        switch self {
        case .some(let value):
            return value.bsonBytes
        case .none:
            return []
        }
    }

    public var bsonType: UInt8 {
        switch self {
        case .some(let value):
            return value.bsonType
        case .none:
            return 0x0A
        }
    }
}
