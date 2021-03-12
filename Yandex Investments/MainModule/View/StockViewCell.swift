//
//  StockViewCell.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 10.03.2021.
//

import UIKit

class StockViewCell: UITableViewCell {

    static let identifier = "StockInfoCell"
    
    @IBOutlet weak var companyImage: UIImageView!
    
    @IBOutlet weak var tickerLabel: UILabel!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var currentPriceLabel: UILabel!
    
    @IBOutlet weak var changePriceLabel: UILabel!
    
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(with stockInfo: StockInfo, at indexPath: Int){
        view.layer.cornerRadius = 20
        tickerLabel.text = stockInfo.symbol
        companyNameLabel.text = stockInfo.companyName
        currentPriceLabel.text = "$\(stockInfo.latestPrice)"
        changePriceLabel.text = "\(stockInfo.change) (\(stockInfo.changePercent)%)"
        
        if stockInfo.change > 0{
            changePriceLabel.textColor = .fromHex("#24B35D")
        }
        else{
            changePriceLabel.textColor = .fromHex("#B32424")
        }
        
        if indexPath % 2 == 0{
            view.backgroundColor = .fromHex("#F0F4F7")
        }
        else{
            view.backgroundColor = .fromHex("#FFFFFF")
        }
        
    
}
}
