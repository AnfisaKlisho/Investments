//
//  UIColor_Hex.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 14.04.2021.
//

import UIKit

public extension UIColor {
    class func fromHex(_ hex: String, alpha: CGFloat = 1) -> UIColor {
        var colorHexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if colorHexString.hasPrefix("#") {
            colorHexString.remove(at: colorHexString.startIndex)
        }

        if (colorHexString.count) != 6 {
            return UIColor.gray.withAlphaComponent(alpha)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: colorHexString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
}
