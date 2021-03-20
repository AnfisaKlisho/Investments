//
//  MainCell.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 18.03.2021.
//

import UIKit

class ChartCell: UICollectionViewCell {
    
    let chartController = DetailViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let chartView = chartController.view!
        addSubview(chartView)
        chartView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

