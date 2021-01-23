//
//  ErrorResponse.swift
//  MovieApp
//
//  Created by Raphael Cerqueira on 18/01/21.
//

import Foundation

struct ErrorResponse: Decodable {
    var status_message: String?
    var status_code: Int?
}
