//
//  ParsableValue.swift
//  ParsableValue
//
//  Created by Christopher Richez on March 4 2022
//

/// A value that can be parsed from its encoded BSON representation.
public protocol ParsableValue {
    /// Initializes this value from the provided BSON bytes.
    /// 
    /// - Parameter data: the encoded value, usually returned by the `ParsedDocument` subscript
    /// 
    /// - Throws:
    /// A `ValueParseError` appropriate for the type to initialize.
    init<Data: Collection>(bsonBytes data: Data) throws where Data.Element == UInt8
}

extension Int32: ParsableValue {
    public init<Data: Collection>(bsonBytes data: Data) throws where Data.Element == UInt8 {
        guard data.count == 4 else { throw ValueParseError.sizeMismatch(4, data.count) }
        let copyBuffer = UnsafeMutableRawBufferPointer.allocate(byteCount: 4, alignment: 4)
        copyBuffer.copyBytes(from: data)
        self = copyBuffer.load(as: Int32.self)
    }
}

extension Int64: ParsableValue {
    public init<Data: Collection>(bsonBytes data: Data) throws where Data.Element == UInt8 {
        guard data.count == 8 else { throw ValueParseError.sizeMismatch(8, data.count) }
        let copyBuffer = UnsafeMutableRawBufferPointer.allocate(byteCount: 8, alignment: 8)
        copyBuffer.copyBytes(from: data)
        self = copyBuffer.load(as: Int64.self)
    }
}

extension UInt64: ParsableValue {
    public init<Data: Collection>(bsonBytes data: Data) throws where Data.Element == UInt8 {
        guard data.count == 8 else { throw ValueParseError.sizeMismatch(8, data.count) }
        let copyBuffer = UnsafeMutableRawBufferPointer.allocate(byteCount: 8, alignment: 8)
        copyBuffer.copyBytes(from: data)
        self = copyBuffer.load(as: UInt64.self)
    }
}

extension Double: ParsableValue {
    public init<Data: Collection>(bsonBytes data: Data) throws where Data.Element == UInt8 {
        guard data.count == 8 else { throw ValueParseError.sizeMismatch(8, data.count) }
        let copyBuffer = UnsafeMutableRawBufferPointer.allocate(byteCount: 8, alignment: 8)
        copyBuffer.copyBytes(from: data)
        self = copyBuffer.load(as: Double.self)
    }
}

extension Bool: ParsableValue {
    public init<Data: Collection>(bsonBytes data: Data) throws where Data.Element == UInt8 {
        guard data.count == 1 else { throw ValueParseError.sizeMismatch(1, data.count) }
        self = data[data.startIndex] == 0 ? false : true
    }
}

extension String: ParsableValue {
    public init<Data: Collection>(bsonBytes data: Data) throws where Data.Element == UInt8 {
        guard data.count > 4 else { throw ValueParseError.dataTooShort(5, data.count) }
        let sizeStart = data.startIndex
        let sizeEnd = data.index(sizeStart, offsetBy: 4)
        // We try! here since we already ensured we have four bytes to read
        let size = Int(try! Int32(bsonBytes: data[sizeStart..<sizeEnd]))
        guard data.count == size + 4 else { 
            throw ValueParseError.sizeMismatch(size + 4, data.count) 
        }
        self.init(decoding: data[sizeEnd..<data.index(data.endIndex, offsetBy: -1)], as: UTF8.self)
    }
}