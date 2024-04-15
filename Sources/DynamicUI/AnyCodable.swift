import Foundation

enum AnyCodable {
    case string(value: String)
    case int(value: Int)
    case data(value: Data)
    case double(value: Double)

    enum AnyCodableError: Error {
        case missingValue
    }
}

extension AnyCodable: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case string, int, data, double
    }

    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(value: int)
            return
        }

        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(value: string)
            return
        }

        if let data = try? decoder.singleValueContainer().decode(Data.self) {
            self = .data(value: data)
            return
        }

        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(value: double)
            return
        }

        throw AnyCodableError.missingValue
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .string(let value):
            try container.encode(value, forKey: .string)
        case .int(let value):
            try container.encode(value, forKey: .int)
        case .data(let value):
            try container.encode(value, forKey: .data)
        case .double(let value):
            try container.encode(value, forKey: .double)
        }
    }
}
