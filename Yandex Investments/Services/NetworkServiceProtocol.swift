//
//  NetworkServiceProtocol.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 21.03.2021.
//

import UIKit

protocol NetworkServiceProtocol{
    func get<Object: Decodable> (type: Object.Type, from urlComponents: URLComponents, completion: @escaping (Result<Object, SessionError>) -> Void)
    
    func getListOfCompanies(_ amount: Int, completion: @escaping (Result<[StockInfo], SessionError>) -> Void)
    func getLogoUrl(for symbol: String, completion: @escaping (Result<ImageInfo, SessionError>) -> Void)
    func getLogoImage(for url: String, completion: @escaping (Result<UIImage, SessionError>) -> Void)
    func getHistoricalData(for symbol: String, completion: @escaping (Result<[DayInfo], SessionError>) -> Void)
    func requestQuote(for symbol: String, completion: @escaping (Result<Quote, SessionError>) -> Void)
    
}
