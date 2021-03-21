//
//  StockInfo.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 04.03.2021.
//

import Foundation

struct StockInfo: Equatable{
    var symbol: String
    var companyName: String
    var latestPrice: Float
    var change: Float
    var changePercent: Float
    var isFavourite: Bool = false
}

private enum CodingKeys: String, CodingKey{
    case symbol
    case companyName
    case latestPrice
    case change
    case changePercent
}

extension StockInfo: Decodable{
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try values.decode(String.self, forKey: .symbol)
        companyName = try values.decode(String.self, forKey: .companyName)
        latestPrice = try values.decode(Float.self, forKey: .latestPrice)
        change = try values.decode(Float.self, forKey: .change)
        changePercent = try values.decode(Float.self, forKey: .changePercent)
    }
}
