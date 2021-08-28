import Foundation

struct EventModel: Decodable, Hashable {
	static func == (lhs: EventModel, rhs: EventModel) -> Bool {
		lhs.id == rhs.id
	}
	
    let id: String
    let title: String
    let description: String
    let image: URL
    let price: Double
    let longitude: Double
    let latitude: Double
    @DateCustom var date: Date
}

@propertyWrapper
struct DateCustom: Decodable, Hashable {
    var wrappedValue: Date
    
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        let timeInterval = try value.decode(TimeInterval.self)
        wrappedValue = Date(timeIntervalSince1970: timeInterval)
    }
}
