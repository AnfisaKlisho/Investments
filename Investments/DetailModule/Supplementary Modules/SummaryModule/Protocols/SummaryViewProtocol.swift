//
//  SummaryViewProtocol.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 22.03.2021.
//

import Foundation

protocol SummaryViewProtocol: class{
    func success()
    func failure(error: Error)
}
