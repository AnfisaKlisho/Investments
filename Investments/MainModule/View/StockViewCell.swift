//
//  StockViewCell.swift
//  Investments
//
//  Created by Anfisa Klisho on 10.03.2021.
//

import UIKit

protocol StockViewCellDelegate: class {
    func cellDidPressFavouriteButton(_ cell: StockViewCell)
    func cellDidLayoutSubviews(_ cell: StockViewCell)
}

class StockViewCell: UITableViewCell {
    
    static let identifier = "StockInfoCell"
    
    @IBOutlet weak var tickerLabel: UILabel!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var currentPriceLabel: UILabel!
    
    @IBOutlet weak var changePriceLabel: UILabel!
    
    @IBOutlet weak var view: UIView!
  
    @IBOutlet weak var companyIcon: UIImageView!
    
    @IBOutlet weak var starButton: UIButton!
    
    
    
    weak var delegate: StockViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = 16
        super.layoutSubviews()
        //delegate?.cellDidLayoutSubviews(self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        companyIcon.image = nil
    }
    
    
    @IBAction func starButtonClicked(_ sender: Any) {
        delegate?.cellDidPressFavouriteButton(self)
    }
    
    
    //MARK:- Configure Cell
    func configure(with stockInfo: StockInfo, at indexPath: Int){
      
        //starButton.setImage(UIImage(named: "greyStar"), for: .normal)
        //starButton.setImage(UIImage(named: "yellowStar"), for: .selected)
        view.layer.cornerRadius = 16
        tickerLabel.text = stockInfo.symbol
        companyNameLabel.text = stockInfo.companyName
        currentPriceLabel.text = "$\(stockInfo.latestPrice)"
        changePriceLabel.text = "$\(stockInfo.change) (\(round(stockInfo.changePercent * 100) / 100)%)"
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
        //starButton.imageView?.image = UIImage(named: "greyStar")
        
    
    }
    
    //MARK:-Configure Image in Cell
    func configureImage(with image: UIImage){
        companyIcon.image = image
    }
    
   
}
