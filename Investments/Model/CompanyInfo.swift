//
//  CompanyInfo.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 22.03.2021.
//

import Foundation

struct CompanyInfo: Decodable{
    var companyName: String
    var description: String
    var sector: String
    var employees: Int?
    var website: String
    var address: String?
    var phone: String?
    var CEO: String
//    var Name: String
//    var Description: String
//    var Sector: String
//    var FullTimeEmployees: String
    
}
