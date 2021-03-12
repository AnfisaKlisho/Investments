//
//  NetworkService.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 03.03.2021.
//

import UIKit

protocol NetworkServiceProtocol{
    func get<Object: Decodable> (type: Object.Type, from urlComponents: URLComponents, completion: @escaping (Result<Object, SessionError>) -> Void)
    
    func getListOfCompanies(_ amount: Int, completion: @escaping (Result<[StockInfo], SessionError>) -> Void)
    
}

class NetworkService: NetworkServiceProtocol{
    //private init() {}
    static let shared = NetworkService()
    
    private let token = "pk_54a1e631e42d4cea8cda7470c5996587"
    private var baseURL: URLComponents{
        var _urlComps = URLComponents(string: "https://cloud.iexapis.com/")!
        _urlComps.queryItems = [URLQueryItem(name: "token", value: token)]
        return _urlComps
    }
    
    private let testToken = "Tpk_0cc2161ac2e946f8b9b6738c04f1e0c6"
    private var testURL: URLComponents{
        var _urlComps = URLComponents(string: "https://sandbox.iexapis.com")!
        _urlComps.queryItems = [URLQueryItem(name: "token", value: testToken)]
        return _urlComps
    }
    
    //MARK:-Get list of companies
    func getListOfCompanies(_ amount: Int = 50, completion: @escaping (Result<[StockInfo], SessionError>) -> Void) {
        var listUrlComponents = baseURL
        listUrlComponents.path = "/stable/stock/market/list/mostactive"
        listUrlComponents.queryItems?.append(URLQueryItem(name: "listLimit", value: "\(amount)"))
        
        get(type: [StockInfo].self, from: listUrlComponents) { (result) in
            completion(result)
        }
    }
    
    //MARK:- Get Request
    internal func get<Object: Decodable> (type: Object.Type, from urlComponents: URLComponents, completion: @escaping (Result<Object, SessionError>) -> Void){
        
        guard let url = urlComponents.url else{
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let error = error{
                DispatchQueue.main.async {
                    completion(.failure(.other(error)))
                }
                return
            }
            
            let response = response as! HTTPURLResponse
            guard let data = data, response.statusCode == 200 else{
                DispatchQueue.main.async {
                    completion(.failure(.serverError(response.statusCode)))
                }
                return
            }
            
            do {
                let object = try JSONDecoder().decode(Object.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(object))
                }
            }
            
            catch let decodingError{
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(decodingError)))
                }
            }
            
            
        }.resume()
    }
}