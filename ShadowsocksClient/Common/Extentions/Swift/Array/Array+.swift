extension Array where Element == UInt8 {
    func calculateChecksum() -> UInt8 {
        let sum = self.reduce(0, ^)
        return UInt8(sum & 0xFF)
    }
}

extension Array where Element == UInt8{
    mutating func put(with newElements: [Element], at position: Int) {
        guard position >= 0 && position < count else {
            fatalError("Invalid position")
        }
        
        guard newElements.count <= count - position else {
            fatalError("Not enough space to replace elements")
        }
        
        for (index, element) in newElements.enumerated() {
            self[position + index] = element
        }
    }
}
