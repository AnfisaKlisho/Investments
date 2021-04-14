//
//  AlertExtension.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 21.03.2021.
//

import UIKit

extension UIViewController{
    
    func showAlert(_ error: Error){
        let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
