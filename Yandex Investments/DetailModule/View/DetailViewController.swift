//
//  DetailViewController.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 18.03.2021.
//

import UIKit
import Charts
import TinyConstraints

class DetailViewController: UIViewController {
    
    var presenter: DetailViewPresenterProtocol!
    //var historicalData: [DayInfo]?
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .white
        //chartView.doubleTapToZoomEnabled = false
        //chartView.pinchZoomEnabled = false
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
        presenter.viewDidLoad(self)
    
       
    }
    
  
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    
    //MARK:-Change
    func setData(){
        var yValues: [ChartDataEntry] = []
        var i = 0
        for item in presenter.historicalData!{
            yValues.append(ChartDataEntry(x: Double(i), y: item.close))
            i += 1
        }
        
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

extension DetailViewController: DetailViewProtocol{
    func success(){
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
      
        
        setData()
    }
}

extension DetailViewController: ChartViewDelegate{
    
}
