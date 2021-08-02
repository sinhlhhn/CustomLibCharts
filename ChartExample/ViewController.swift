//
//  ViewController.swift
//  ChartExample
//
//  Created by Lê Hoàng Sinh on 8/3/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import UIKit
import Charts
import SwiftSoup
import KRWalkThrough


class ViewController: UIViewController {

    
//    @IBOutlet weak var chartView: UIView!
    
    var combineChart = BudgetCombineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        combineChart.delegate = self
        
        customCharts()
        getDayOfMonth()
        setUpChart()
    }
    
    override func viewDidLayoutSubviews() {
         
    }
    override func viewWillAppear(_ animated: Bool) {
        self.combineChart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    func setUpChart() {
        //frame
        combineChart.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 170) //tạo frame để chứa biểu đồ
        combineChart.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(combineChart)
        
        // marker
//        let markerView = BalloonMarker(color: .black, font: UIFont.boldSystemFont(ofSize: 14), textColor: .white, insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
//        markerView.chartView = combineChart
//        combineChart.marker = markerView
        
        // dòng đỏ trên cùng
        
        let limitLine = ChartLimitLine()
        limitLine.lineColor = UIColor.red
        limitLine.lineDashLengths = [5]
        
        limitLine.limit = 10
        combineChart.leftAxis.addLimitLine(limitLine)

        //legend
        combineChart.legend.form = .none
        combineChart.legend.neededHeight = 0
        
        //entry
        var entries = [BarChartDataEntry]()
        var entries2 = [BarChartDataEntry]()// tạo mảng giá trị của biểu đồ
        var lineEntries = [ChartDataEntry]()
        
        let arr:[Double] = [1,3,2,4,6,5,7,
                            1,3,2,4,6,5,7,
                            1,3,2,4,6,5,7,
                            1,3,2,4,6,5,7,
                            9,10]
        
        let arr2:[Double] = [10,11,10,9,8,7,2,
                             10,11,10,9,8,7,2,
                             10,11,10,9,8,7,2,
                             10,11,10,9,8,7,2,
                             10,11]
        let lineChartEntry: [Double] = [12,11,11,9,6,4,2,0,
                                        12,11,11,9,6,4,2,0,
                                        12,11,11,9,6,4,2,0,
                                        12,11,11,9,6,4,2,0,
                                        12,11]
        for i in 0..<30 {
            entries.append(BarChartDataEntry( x:Double(i),y: arr[i]))
            entries2.append(BarChartDataEntry(x: Double(Double(i)), y: arr2[i]))
            lineEntries.append(ChartDataEntry(x: Double(i)+0.5, y: lineChartEntry[i]))
            /**
            khởi taọ các giá trị
             x: giá trị của các dòng
             y: giá trị của các cột
             */
        }
        
        // xAxis
        let months = ["01/05", "02", "03", "04", "05", "06", "07","8",
                      "9", "10", "11", "12", "13", "14", "15","16",
                      "17", "18", "19", "20", "21", "22", "23","24",
                      "25", "26", "27", "28", "29", "30"]
        combineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: months) // thay các giá trị index mặc định thành kiểu String
        combineChart.xAxis.labelCount = 30 // số giá trị hiển thị của dòng
        combineChart.xAxis.centerAxisLabelsEnabled = true
        combineChart.xAxis.labelPosition = .bottom // hiển thị giá trị ở phía dưới
        combineChart.xAxis.granularityEnabled = true // tránh làm tròn vị trí label. Nếu làm tròn thì dẫn đến bị đè lên nhau
        combineChart.xAxis.drawGridLinesEnabled = true // xoá line trong biểu đồ
        combineChart.xAxis.gridLineDashLengths = [CGFloat(5)]
        
        //left axis
        let valFormatter = NumberFormatter() //tạo biến format dữ liệu
        valFormatter.numberStyle = .currency //chọn kiểu
        valFormatter.maximumFractionDigits = 0 // số chữ số thập phân hiển thị
        valFormatter.currencySymbol = "$" // chọn kí tự đặc biệt hiển thị
        combineChart.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter) // format dữ liệu
        combineChart.leftAxis.labelCount = 4
//        combineChart.leftAxis.drawAxisLineEnabled = false // xoá cột phải
        combineChart.leftAxis.gridLineDashLengths = [CGFloat(5)]
        combineChart.leftAxis.axisMinimum = 0 // đưa trục x về vị trí cuối cùng
            
        combineChart.rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter) // format dữ liệu
        combineChart.rightAxis.labelCount = 4
//        combineChart.rightAxis.drawAxisLineEnabled = false // xoá cột phải
        combineChart.rightAxis.gridLineDashLengths = [CGFloat(5)]
        combineChart.rightAxis.axisMinimum = 0 // đưa trục x về vị trí cuối cùng
        
        // chart set
        
        let barChartSet = BarChartDataSet(entries: entries,label: nil) // các giá trị cần hiển thị
        let barChartSet2 = BarChartDataSet(entries: entries2,label: nil)
        
        let lineChartSet = LineChartDataSet(entries: lineEntries, label: nil)
        
        //color
        var barChartSetColor1 = [NSUIColor]()
        var barChartSetColor2 = [NSUIColor]()
        var lineChartSetColor = [NSUIColor]()
        var lineChartSetCircleColor = [NSUIColor]()
        
        for i in 0 ... 29 {
            if i < day {
                barChartSetColor1.append(NSUIColor.orange)
                barChartSetColor2.append(NSUIColor.blue)
                lineChartSetCircleColor.append(NSUIColor.green)
                lineChartSetColor.append(NSUIColor.green)
            } else {
                barChartSetColor1.append(NSUIColor.gray.withAlphaComponent(0.8))
                barChartSetColor2.append(NSUIColor.gray.withAlphaComponent(0.8))
                lineChartSetColor.append(NSUIColor.gray)
                lineChartSetCircleColor.append(NSUIColor.gray)
            }
        }
        
        barChartSet.colors = barChartSetColor1
        barChartSet2.colors = barChartSetColor2
        lineChartSet.colors = lineChartSetColor
        
        lineChartSet.circleColors = [NSUIColor.white]
        lineChartSet.circleHoleColor = NSUIColor.green
        
        // bar chart set
        barChartSet.drawValuesEnabled = false
        barChartSet2.drawValuesEnabled = false
        
        //line chart set
        lineChartSet.circleRadius = 5
        lineChartSet.circleHoleRadius = 3
        lineChartSet.drawValuesEnabled = false
        lineChartSet.lineWidth = 2
        lineChartSet.setDrawHighlightIndicators(true)
        lineChartSet.drawHorizontalHighlightIndicatorEnabled = false
        lineChartSet.lineDashPhase = 5
        lineChartSet.lineDashLengths = [5, 5]
        
        lineChartSet.highlightColor = UIColor.gray.withAlphaComponent(0.5)
        
        
        
        let chartData = CombinedChartData()
        
        //group
        let groupSpace = 0.4
               let barSpace = 0.0
        let barWidth = 0.3
        //so group = 2
               // (0.3 + 0.0) * 2 + 0.4 = 1.00 -> interval per "group"
        
        let test = BarChartData(dataSets: [barChartSet,barChartSet2])
        test.barWidth = barWidth
        test.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        let gw = test.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        chartData.notifyDataChanged()
        chartData.barData =  test // chuyển thành dữ liệu
        
        test.highlightEnabled = false
        
        let start = 0.5
        combineChart.xAxis.axisMaximum = start + gw + 28.5 // = 30 = số giá trị hiển thị trên trục x
        
        // line data
        let lineData = LineChartData(dataSet: lineChartSet)
        lineData.highlightEnabled = true
        chartData.lineData = lineData
        combineChart.data = chartData // hiển thị dữ liệu ( bắt đầu gọi combine chart render)
        
        //combine chart
        //32 = tổng độ rộng 2 cột
        //21.3 = tổng độ rộng 2 cột * groupSpace / barWidth
        let maxRange = Double(view.frame.width - 35)/(32+21.3)
        combineChart.setVisibleXRangeMaximum(maxRange)
//        combineChart.moveViewToX(<#Double#>)
        combineChart.dragEnabled = true
        combineChart.scaleYEnabled = false
        combineChart.scaleXEnabled = false
        combineChart.doubleTapToZoomEnabled = false
        combineChart.noDataText = "No Data " // thông báo khi ko có dữ liêuh
        combineChart.rightAxis.enabled = false // ẩn thanh giá trị bên phải
    
        lineChartSet.highlightLineWidth = 32 // = 16 * 2 = tổng độ rộng 2 cột
        
        print(combineChart.frame.width)
        
        
        
        //comment
        
        //legend: vị trí của chú thích
        
//        let firstLegend = LegendEntry()
//        firstLegend.label = "Left amount Left amount"
//        firstLegend.formColor = .red
//
//        let secondLegend = LegendEntry()
//        secondLegend.label = "Total spent"
//        secondLegend.formColor = .blue
//
//        let thirdLegend = LegendEntry()
//        thirdLegend.label = "Spend by day"
//        thirdLegend.formColor = .green
//
//
//
//        let legend = combineChart.legend
//        legend.setCustom(entries: [firstLegend, secondLegend, thirdLegend])
//        legend.orientation = .horizontal
//        legend.textColor = UIColor.black
//        legend.font = UIFont.boldSystemFont(ofSize: 14)
        
        //        barChart.xAxis.axisMinimum = 0.5
        
        //self.barChart.gridBackgroundColor = NSUIColor.red
        //self.barChart.chartDescription?.text = "Barchart Days and Gross"//chú thích ở góc màn hình
//        self.barChart.xAxis.axisRange = 1.0
        
//        barChart.xAxis.granularity = 0.5 // giá trị hiển thị giữa các dòng
        
        //        legend.horizontalAlignment = .right
        //        legend.verticalAlignment = .top
        //        legend.orientation = .vertical
        //        legend.drawInside = true
        //        legend.yOffset = 10.0;
        //        legend.xOffset = 10.0;
        //        legend.yEntrySpace = 0.0;
        //        barChart.xAxis.drawAxisLineEnabled = false
       
    }
    
    var day = 0
    
    func getDayOfMonth() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let dayString = formatter.string(from: Date())
        day = Int(dayString) ?? 0
    }
    
    func customCharts() {
        let viewPortHandler = combineChart.viewPortHandler
        let xAxis = combineChart.xAxis
        let yAxis = combineChart.leftAxis
        let transformer = combineChart.getTransformer(forAxis: .right)
        let animator = combineChart.chartAnimator
        
        let render = BudgetCombinedChartRenderer(chart: combineChart, animator: animator!, viewPortHandler: viewPortHandler!)
        
        
        
        combineChart.xAxisRenderer = BudgetXAxisRenderer(viewPortHandler: viewPortHandler!, xAxis: xAxis, transformer: transformer)
        combineChart.leftYAxisRenderer = BudgetYAxisRenderer(viewPortHandler: viewPortHandler!, yAxis: yAxis, transformer: transformer)
        
        self.combineChart.renderer = render
        

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.combineChart.moveViewToX(2)// scroll đến cột thứ x
        }
        
        
    }

}

extension ViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        
    }
    
}

