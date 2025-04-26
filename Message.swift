//
//  Message.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/13.
//


import Foundation
import PhotosUI

struct Message: Identifiable {
    let id: UUID
    let role: Role
    var text: String
    var versions: [String]
    var image: UIImage? = nil
    var structured: GPTStructuredResponse?
    var createdAt: Date = Date()

    enum Role: String {
        case user
        case ai
        case system
    }

    init(
        id: UUID = UUID(),
        role: Role,
        text: String,
        versions: [String] = [],
        structured: GPTStructuredResponse? = nil,
        createdAt: Date = Date(),
        image: UIImage? = nil
    ) {
        self.id = id
        self.role = role
        self.text = text
        self.versions = versions
        self.structured = structured
        self.createdAt = createdAt
        self.image = image
    }
}
