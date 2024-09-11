extension UInt32 {
    init(littleEndianBytes bytes: [UInt8]) {
        precondition(bytes.count == 4)
        self = UInt32(bytes[0]) | UInt32(bytes[1]) << 8 | UInt32(bytes[2]) << 16 | UInt32(bytes[3]) << 24
    }
}

extension UInt16 {
    init(littleEndianBytes bytes: [UInt8]) {
        precondition(bytes.count == 2)
        self = UInt16(bytes[0]) | UInt16(bytes[1]) << 8
    }
}

//extension Int {
//    init(littleEndianBytes bytes: [UInt8]) {
//        precondition(bytes.count == MemoryLayout<Int>.size)
//        self = bytes.withUnsafeBytes { $0.load(as: Int.self) }
//    }
//}
extension Int {
    init(littleEndianBytes bytes: [UInt8]) {
        precondition(bytes.count == MemoryLayout<Int>.size, "Byte array size does not match Int size")
        var value: Int = 0
        for (index, byte) in bytes.enumerated() {
            value |= Int(byte) << (8 * index)
        }
        
        self = value
    }
}

extension Int {
    var toBool: Bool {
        return self != 0
    }
}

//extension Int {
//    init(littleEndian bytes: [UInt8]) {
//        let u32 = bytes.reversed().reduce(0) { soFar, byte in
//            return soFar << 8 | UInt32(byte)
//        }
//        self = Int(u32)
//    }
//}
