//
//  ChartViewController.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 21.03.2021.
//

import UIKit
import Charts
import TinyConstraints

class ChartViewController: UIViewController {

    var presenter: ChartViewPresenterProtocol!
    

    @IBOutlet weak var marginsView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changePriceLabel: UILabel!
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .white
        chartView.setScaleEnabled(false)

        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.drawAxisLineEnabled = false
        yAxis.drawLabelsEnabled = false
        yAxis.drawGridLinesEnabled = false


        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawLabelsEnabled = false

        chartView.animate(xAxisDuration: 2)

        return chartView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lineChartView)
        //lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        
        NSLayoutConstraint.activate([lineChartView.topAnchor.constraint(equalTo: changePriceLabel.bottomAnchor, constant: 10)])
        
        setData()
        setupLabels()
 
    }
    
  
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setupLabels(){
        priceLabel.text = presenter.getPrice()
        changePriceLabel.text = presenter.getChangePrice()
        let positive = presenter.isChangePositive()
        if positive{
            changePriceLabel.textColor = .fromHex("#24B35D")
        }
        else{
            changePriceLabel.textColor = .fromHex("#B32424")
    }
    }
    
    
    func setData(){
        let yValues = presenter.getArrayWithCoordinates()
        let set1 = LineChartDataSet(entries: yValues)
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 2
        set1.setColor(.black)
        let gradientColors = [UIColor.black.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        set1.fill = LinearGradientFill(gradient: gradient!, angle: 90.0)
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)

        lineChartView.data = data
    }
  
    
}

extension ChartViewController: ChartViewProtocol{
    
}

extension ChartViewController: ChartViewDelegate{
    
}
