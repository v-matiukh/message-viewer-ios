//
//  Message.swift
//  MessageViewer
//
//  Created by Volodymyr Matiukh on 19.09.2024.
//

import Foundation

struct Message: Identifiable, Codable {
    let id: UUID
    let text: String
    let date: Date
}
