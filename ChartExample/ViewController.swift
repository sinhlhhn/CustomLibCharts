//
//  ViewController.swift
//  ChartExample
//
//  Created by Lê Hoàng Sinh on 8/3/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import UIKit
import Charts


class ViewController: UIViewController {

    
//    @IBOutlet weak var chartView: UIView!
    
    var combineChart = BudgetCombineChartView()
    var isRemove = false
    
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
    
    @IBAction func buttonTapped(_ sender: Any) {
        combineChart.removeFromSuperview()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setUpChart()
        }
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
        var lineEntries2 = [ChartDataEntry]()
        
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
        let lineChartEntry: [Double] = [12,11]
        let lineChartEntry2: [Double] = [11,11,9,6,4,2,0,
                                        12,11,11,9,6,4,2,0,
                                        12,11,11,9,6,4,2,0,
                                        12,11,11,9,6,4,2,0,
                                        12,11]
        for i in 0..<30 {
            entries.append(BarChartDataEntry( x:Double(i),y: arr[i]))
            entries2.append(BarChartDataEntry(x: Double(Double(i)), y: arr2[i]))
            if i < lineChartEntry.count {
                lineEntries.append(ChartDataEntry(x: Double(i)+0.5, y: lineChartEntry[i]))
                if i == lineChartEntry.count - 1 {
                    lineEntries2.append(ChartDataEntry(x: Double(i)+0.5, y: lineChartEntry2[i]))
                }
            } else {
                lineEntries2.append(ChartDataEntry(x: Double(i)+0.5, y: lineChartEntry2[i]))
            }
            
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
        
        let barChartSet = BarChartDataSet(entries: entries,label: "") // các giá trị cần hiển thị
        let barChartSet2 = BarChartDataSet(entries: entries2,label: "")
        
        let lineChartSet = LineChartDataSet(entries: lineEntries, label: "")
        let lineChartSet2 = LineChartDataSet(entries: lineEntries2, label: "")
        
        //color
        var barChartSetColor1 = [NSUIColor]()
        var barChartSetColor2 = [NSUIColor]()
        
        for i in 0 ... 29 {
            if i < day {
                barChartSetColor1.append(NSUIColor.orange)
                barChartSetColor2.append(NSUIColor.blue)
                
            } else {
                barChartSetColor1.append(NSUIColor.gray.withAlphaComponent(0.8))
                barChartSetColor2.append(NSUIColor.gray.withAlphaComponent(0.8))
            }
        }
        
        barChartSet.colors = barChartSetColor1
        barChartSet2.colors = barChartSetColor2
        
        lineChartSet.colors = [NSUIColor.green]
        
        lineChartSet.circleColors = [NSUIColor.white]
        lineChartSet.circleHoleColor = NSUIColor.green
        lineChartSet2.circleColors = [NSUIColor.white]
        lineChartSet2.circleHoleColor = NSUIColor.green
        
        lineChartSet2.colors = [NSUIColor.gray]
        
        
        // bar chart set
        barChartSet.drawValuesEnabled = false
        barChartSet2.drawValuesEnabled = false
        
        //line chart set
        lineChartSet.circleRadius = 5
        lineChartSet.circleHoleRadius = 4
        lineChartSet.drawValuesEnabled = false
        lineChartSet.lineWidth = 2
        lineChartSet.setDrawHighlightIndicators(true)
        lineChartSet.drawHorizontalHighlightIndicatorEnabled = false
        
        lineChartSet2.circleRadius = 5
        lineChartSet2.circleHoleRadius = 4
        lineChartSet2.drawValuesEnabled = false
        lineChartSet2.lineWidth = 2
        lineChartSet2.setDrawHighlightIndicators(true)
        lineChartSet2.drawHorizontalHighlightIndicatorEnabled = false
        lineChartSet2.lineDashPhase = 5
        lineChartSet2.lineDashLengths = [5, 5]
        
        lineChartSet.highlightColor = UIColor.gray.withAlphaComponent(0.5)
        lineChartSet2.highlightColor = UIColor.gray.withAlphaComponent(0.5)
        
        
        
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
        
        test.isHighlightEnabled = false
        
        let start = 0.5
        combineChart.xAxis.axisMaximum = start + gw + 28.5 // = 30 = số giá trị hiển thị trên trục x
        
        // line data
        let lineData = LineChartData(dataSets: [lineChartSet,lineChartSet2])
        lineData.isHighlightEnabled = true
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
        lineChartSet2.highlightLineWidth = 32
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
        
        let render = BudgetCombinedChartRenderer(chart: combineChart, animator: animator, viewPortHandler: viewPortHandler)
        
        
        
        combineChart.xAxisRenderer = BudgetXAxisRenderer(viewPortHandler: viewPortHandler, axis: xAxis, transformer: transformer)
        combineChart.leftYAxisRenderer = BudgetYAxisRenderer(viewPortHandler: viewPortHandler, axis: yAxis, transformer: transformer)
        
        self.combineChart.renderer = render
        

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.combineChart.moveViewToX(2)// scroll đến cột thứ x
        }
        
        
    }

}

extension ViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        removeMarkerView()
//        self.createMarkerView(position: highlight.xPx)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.isRemove = false
//        }
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
//        removeMarkerView()
    }
    
    func chartViewDidEndPanning(_ chartView: ChartViewBase) {
//        removeMarkerView()
    }
}

extension ViewController {
    func createMarkerView(position: CGFloat) {
        let isLeft = position <= view.frame.width/2
        if isLeft {
            let markerView = UIView()
            markerView.tag = 999
            markerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(markerView)
            markerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
            markerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
            markerView.widthAnchor.constraint(equalToConstant: 168).isActive = true
            markerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            markerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        } else {
            let markerView = UIView()
            markerView.tag = 999
            markerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(markerView)
            markerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
            markerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
            markerView.widthAnchor.constraint(equalToConstant: 168).isActive = true
            markerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            markerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }
    }
    
    func removeMarkerView() {
        for subView in view.subviews {
            if subView.tag == 999 {
                subView.removeFromSuperview()
            }
        }
    }
}

