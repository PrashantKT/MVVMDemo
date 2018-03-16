// To parse the JSON, add this file to your project and do:
//
//   let speaker = try Speaker(json)

import Foundation

struct Speaker: Codable {
    let success: Bool
    let data: [ResultSpeaker]
    let message: String
}

struct ResultSpeaker: Codable {
    
    let id: Int
    let name, shortDescription, detailedDescription, twitterProfile: String?
    let linkedinProfile, image: String?
    let location: String?
    let time: String?
    let createdAt, updatedAt: String?
    let timeFrom, timeTo: String?
    let date:String?
    

    
    enum CodingKeys: String, CodingKey {
        case id, name
        case shortDescription = "short_description"
        case detailedDescription = "detailed_description"
        case twitterProfile = "twitter_profile"
        case linkedinProfile = "linkedin_profile"
        case image, location, time,date
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case timeFrom = "time_from"
        case timeTo = "time_to"
    }
}

enum Location: String, Codable {
    case centerRoom = "Center Room"
}

enum Time: String, Codable {
    case the12001300 = "12:00 - 13:00"
}


// MARK: Convenience initializers

extension Speaker {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Speaker.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension ResultSpeaker {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ResultSpeaker.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
