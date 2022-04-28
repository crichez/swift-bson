//
//  BinaryParsableValue.swift
//  
//
//  Created by Christopher Richez on 4/28/22.
//

/// A BSON value whose encoded form declares the BSON binary type (5).
///
/// Conform to `BinaryParsableValue` for BSON binary values to inherit metadata parsing.
public protocol BinaryParsableValue: ParsableValue {
    /// Initializes a value from the provided BSON data.
    ///
    /// - Parameter bsonValueBytes: the value's encoded bytes, not including size and subtype bytes
    ///
    /// - Throws: The appropriate ``ValueParseError``.
    init<Data: Collection>(bsonValueBytes: Data) throws where Data.Element == UInt8
}

extension BinaryParsableValue {
    public init<Data: Collection>(bsonBytes data: Data) throws where Data.Element == UInt8 {
        guard data.count >= 5 else { throw ValueParseError.dataTooShort(5, data.count) }
        let declaredSize = Int(truncatingIfNeeded: try Int32(bsonBytes: data.prefix(4)))
        guard data.count == declaredSize + 5 else {
            throw ValueParseError.sizeMismatch(declaredSize + 5, data.count)
        }
        try self.init(bsonValueBytes: data.dropFirst(5))
    }
}
