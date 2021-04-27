//
//  ProfileViewPresenterProtocol.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 29.03.2021.
//

import Foundation

protocol ProfileViewPresenterProtocol{
    init(view: ProfileViewProtocol, networkService: NetworkServiceProtocol, stock: StockInfo?)
    var stock: StockInfo? {get set}
    func loadCompanyInfo()
    func getInfo() -> CompanyInfo?
}
