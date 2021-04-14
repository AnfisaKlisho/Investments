//
//  Quote.swift
//  Investments
//
//  Created by Anfisa Klisho on 18.03.2021.
//

import Foundation

struct Quote: Decodable{
//    var symbol: String
//    var companyName: String
//    var latestPrice: Double
//    var change: Double
//    var changePercent: Double
    
    var open: Double?
    var week52High: Double?
    var week52Low: Double?
    var peRatio: Double?
    var marketCap: Double?
    var previousClose: Double?
    var volume: Double?
}


