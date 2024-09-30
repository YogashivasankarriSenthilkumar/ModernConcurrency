//
//  ToDo.swift
//  CombineAndModernConcurrency
//
//  Created by Yogashivasankarri Senthilkumar on 21/05/24.
//

import Foundation
import UIKit

struct Products: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}
