//
//  StockViewCell.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 10.03.2021.
//

import UIKit

class StockViewCell: UITableViewCell {

    static let identifier = "StockInfoCell"
    
    @IBOutlet weak var tickerLabel: UILabel!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var currentPriceLabel: UILabel!
    
    @IBOutlet weak var changePriceLabel: UILabel!
    
    @IBOutlet weak var view: UIView!
  
    @IBOutlet weak var companyIcon: UIImageView!
    
    @IBOutlet weak var starButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = 16
        super.layoutSubviews()
    }
    
    
    @IBAction func starButtonClicked(_ sender: Any) {
        
    }
    
    
    //MARK:- Configure Cell
    func configure(with stockInfo: StockInfo, at indexPath: Int){
        view.layer.cornerRadius = 16
        tickerLabel.text = stockInfo.symbol
        companyNameLabel.text = stockInfo.companyName
        currentPriceLabel.text = "$\(stockInfo.latestPrice)"
        changePriceLabel.text = "\(stockInfo.change) (\(round(stockInfo.changePercent * 100) / 100)%)"
        companyIcon.layer.cornerRadius = 16
        
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
    
    //MARK:-Configure Image in Cell
    func configureImage(with image: UIImage){
        companyIcon.image = image
    }
}
