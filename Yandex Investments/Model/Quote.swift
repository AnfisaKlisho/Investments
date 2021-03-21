//
//  Quote.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 18.03.2021.
//

import Foundation

struct Quote: Decodable{
    var open: Double?
    var week52High: Double?
    var week52Low: Double?
    var peRatio: Double?
    var marketCap: Double?
    var previousClose: Double?
    //var iexBidPrice: Double?
    //var iexAskPrice: Double?
    var volume: Double?
}

//private enum CodingKeys: String, CodingKey{
//    case open, week52High, week52Low, peRatio, marketCap, previousClose, iexBidPrice, iexAskPrice, volume
//
//}
//
//extension Quote: Decodable{
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//
//        open = try values.decode(Double.self, forKey: .open)
//        week52High = try values.decode(Double.self, forKey: .week52High)
//        week52Low = try values.decode(Double.self, forKey: .week52Low)
//        peRatio = try values.decode(Double.self, forKey: .peRatio)
//        marketCap = try values.decode(Int.self, forKey: .marketCap)
//        previousClose = try values.decode(Double.self, forKey: .previousClose)
//        iexBidPrice = try values.decode(Double.self, forKey: .iexBidPrice)
//        iexAskPrice = try values.decode(Double.self, forKey: .iexAskPrice)
//        volume = try values.decode(Int.self, forKey: .volume)
//    }
//}
