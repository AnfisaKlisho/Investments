//
//  StockInfo.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 04.03.2021.
//

import Foundation

struct StockInfo: Decodable, Equatable{
    var symbol: String
    var companyName: String
    var latestPrice: Float
    var change: Float
    var changePercent: Float
    
}
