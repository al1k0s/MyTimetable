
public protocol Identifieble {
    var id: Int { get }
}

public struct ForeignKey<T: Identifieble>: RawRepresentable, Codable {
    public var rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public func get<B: Sequence>(from sequence: B) -> T? where B.Element == T {
        return sequence.first {
            $0.id == rawValue
        }
    }
}
