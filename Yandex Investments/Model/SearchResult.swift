//
//  SearchResult.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 23.03.2021.
//

import Foundation

struct SearchResult: Decodable {
    var symbol: String


    enum CodingKeys: String, CodingKey{
        case symbol = "1. symbol"
}

}
