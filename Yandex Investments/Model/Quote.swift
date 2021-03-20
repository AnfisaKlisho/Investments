//
//  Quote.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 18.03.2021.
//

import Foundation

struct Quote: Decodable{
    //var open: Double
    //var close: Double
    var week52High: Double
    var week52Low: Double
    var peRatio: Double
    var marketCap: Double
    var previousClose: Double
    var iexBidPrice: Double
    var iexAskPrice: Double
    var iexOpen: Double
}
