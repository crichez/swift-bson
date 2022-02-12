//
//  Chains.swift
//
//
//  Created by Christopher Richez on February 11 2022
//

struct Chain2<S0, S1>: Sequence 
where S0 : Sequence, S1 : Sequence, S0.Element == UInt8, S1.Element == UInt8 {
    let s0: S0
    let s1: S1

    init(_ s0: S0, _ s1: S1) {
        self.s0 = s0
        self.s1 = s1
    }

    init<T0, T1>(_ t0: T0, _ t1: T1) throws 
    where T0 : BinaryConvertible, T1 : BinaryConvertible, T0.Encoded == S0, T1.Encoded == S1 {
        s0 = try t0.encode()
        s1 = try t1.encode()
    }

    struct Iterator: IteratorProtocol {
        var i0: S0.Iterator
        var i1: S1.Iterator

        init(_ s0: S0, _ s1: S1) {
            i0 = s0.makeIterator()
            i1 = s1.makeIterator()
        }

        mutating func next() -> UInt8? {
            if let next = i0.next() {
                return next
            } else if let next = i1.next() {
                return next
            } else {
                return nil
            }
        }
    }

    func makeIterator() -> Iterator {
        Iterator(s0, s1)
    }
}
