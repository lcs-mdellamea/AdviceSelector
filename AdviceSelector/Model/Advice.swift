//
//  Advice.swift
//  AdviceSelector
//
//  Created by Madison Dellamea on 2022-11-04.
//

import Foundation

// The Advice structure conforms to the
// Decodable protocol. This means that we want
// Swift to be able to take a JSON object
// and 'decode' into an instance of this
// structure
struct Advice: Decodable, Hashable {
    let id: String
    let advice: String
    let status: Int
}
