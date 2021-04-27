//
//  ServerResponse.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 23.03.2021.
//

import Foundation

struct ServerResponse: Decodable{
    var bestMatches: [SearchResult]
}
