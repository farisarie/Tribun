//
//  News.swift
//  Tribun
//
//  Created by yoga arie on 16/10/23.
//

import Foundation


struct News: Decodable {
    let message: String
    let total: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Decodable {
    let title: String
    let link: String
    let contentSnippet, isoDate: String
    let image: String
}
