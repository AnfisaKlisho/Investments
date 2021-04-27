//
//  ProfileViewProtocol.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 29.03.2021.
//

import Foundation

protocol ProfileViewProtocol: class{
    func success()
    func failure(error: Error)
}
