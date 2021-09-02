// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import SwiftUI


// MARK: - Welcome
struct Welcome: Codable {
    let success: Bool
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable, Identifiable {
    let id: String
    let sportKey: String
    let sportNice: String
    let teams: [String]
    let commenceTime: Int
    let homeTeam: String
    let sites: [Site]
    let sitesCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case sportKey = "sport_key"
        case sportNice = "sport_nice"
        case teams
        case commenceTime = "commence_time"
        case homeTeam = "home_team"
        case sites
        case sitesCount = "sites_count"
    }
}

// MARK: - Site
struct Site: Codable {
    let siteKey, siteNice: String
    let lastUpdate: Int
    let odds: Odds

    enum CodingKeys: String, CodingKey {
        case siteKey = "site_key"
        case siteNice = "site_nice"
        case lastUpdate = "last_update"
        case odds
    }
}

// MARK: - Odds
struct Odds: Codable {
    let h2H: [Double]

    enum CodingKeys: String, CodingKey {
        case h2H = "h2h"
    }
}
