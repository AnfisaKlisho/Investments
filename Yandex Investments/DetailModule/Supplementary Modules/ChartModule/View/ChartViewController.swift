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
    let markerView = MarkerView()

    @IBOutlet weak var buyButton: UIButton!
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
        yAxis.drawLabelsEnabled = true
        yAxis.drawGridLinesEnabled = false


        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawLabelsEnabled = false
        
        //chartView.drawMarkers = true

        chartView.animate(xAxisDuration: 2)

        return chartView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lineChartView)
        //lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        //lineChartView.delegate = self
        
        NSLayoutConstraint.activate([lineChartView.topAnchor.constraint(equalTo: changePriceLabel.bottomAnchor, constant: 10)])
        

//        let marker = BalloonMarker
//        marker.chartView = lineChartView
//        //marker.minimumSize = CGSize(width: 80, height: 40)
//        lineChartView.marker = marker
        setData()
        setupLabels()
        setupButton()
        let marker = PillMarker(color: .white, font: UIFont.boldSystemFont(ofSize: 14), textColor: .black)
        lineChartView.marker = marker
//
//    }
//
//    public override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
////        label.text = String.init(format: "%d %%", Int(round(entry.y)))
////        layoutIfNeeded()
        

        
    }
    
    
    
  
    func setupButton(){
        let priceString = presenter.getPrice()
        buyButton.titleLabel?.text = "Buy for \(priceString)"
        buyButton.layer.cornerRadius = 16
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
        set1.drawCirclesEnabled = true
        set1.circleColors = [UIColor.black]
        set1.circleRadius = 4
        set1.drawVerticalHighlightIndicatorEnabled = false
        set1.highlightColor = .black
        set1.lineWidth = 2
        set1.setColor(.black)
        let gradientColors = [UIColor.black.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        set1.fill = LinearGradientFill(gradient: gradient!, angle: 90.0)
        set1.drawFilledEnabled = true
        
        lineChartView.data?.isHighlightEnabled = true
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)

        lineChartView.data = data
    }
  
    
}

extension ChartViewController: ChartViewProtocol{
    
}

extension ChartViewController: ChartViewDelegate{
//    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        let markerPosition = chartView.getMarkerPosition(highlight: highlight)
//
//      // Adding top marker
//        markerView.valueLabel.text = "\(entry.x)"
//        //markerView.dateLabel.text = "\(months[entry.xIndex])"
//        markerView.center = CGPoint(x: markerPosition.x, y: markerView.center.y)
//        markerView.isHidden = false
    
    
    
}

//class MarkerView: UIView{
//    var valueLabel: UILabel!
//    var metricLabel: UILabel!
//    //var dateLabel: UILabel!
//}
