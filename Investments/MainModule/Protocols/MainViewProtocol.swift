//
//  MainViewProtocol.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 21.03.2021.
//

import UIKit

protocol MainViewProtocol: class{
    func success()
    func failure(error: Error)
    func showDetailedVC(stock: StockInfo)
    func setImage(_ image: UIImage, at index: Int)
    func updateRow(at index: Int)
}
