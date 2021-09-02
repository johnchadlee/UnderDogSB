//
//  games.swift
//  UnderDog Prototype
//
//  Created by John Lee on 3/21/21.
//
import Foundation
import SwiftUI

struct Initial: Codable {
//    let id = UUID()
    let success: Bool
    let data: [Datas]
    struct Datas: Codable, Identifiable {
        let id = UUID()
        let key: String
        let active: Bool
        let group: String
        let details: String
        let title: String
        let hasOutrights: Bool
        
        enum CodingKeys: String, CodingKey {
            case key, active, group, details, title
            case hasOutrights = "has_outrights"
            }
        }
}
