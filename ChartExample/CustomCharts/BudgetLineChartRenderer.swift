//
//  BudgetLineScatterCandleRadarRenderer.swift
//  ChartExample
//
//  Created by Lê Hoàng Sinh on 14/05/2021.
//  Copyright © 2021 Lê Hoàng Sinh. All rights reserved.
//

import Foundation
import Charts

// highlight chart
class BudgetLineChartRenderer: LineChartRenderer {
    
    
    override open func drawData(context: CGContext)
    {
        guard let lineData = dataProvider?.lineData else { return }
        
        for i in 0 ..< lineData.dataSetCount
        {
            guard let set = lineData.getDataSetByIndex(i) else { continue }
            
            if set.isVisible
            {
                if !(set is ILineChartDataSet)
                {
                    fatalError("Datasets for LineChartRenderer must conform to ILineChartDataSet")
                }
                drawDataSet(context: context, dataSet: set as! ILineChartDataSet, index: i)
            }
        }
    }
    
    @objc func drawDataSet(context: CGContext, dataSet: ILineChartDataSet, index: Int)
    {
        if dataSet.entryCount < 1
        {
            return
        }
        
        context.saveGState()
        context.setLineWidth(dataSet.lineWidth)
        if dataSet.lineDashLengths != nil && index > 1
        {
            context.setLineDash(phase: dataSet.lineDashPhase, lengths: dataSet.lineDashLengths!)
        }
        else
        {
            context.setLineDash(phase: 0.0, lengths: [])
        }
        
        context.setLineCap(dataSet.lineCapType)
        
        // if drawing cubic lines is enabled
        switch dataSet.mode
        {
        case .linear: fallthrough
        case .stepped:
            drawLinear(context: context, dataSet: dataSet)
            
        case .cubicBezier:
            drawCubicBezier(context: context, dataSet: dataSet)
            
        case .horizontalBezier:
            drawHorizontalBezier(context: context, dataSet: dataSet)
        }
        
        context.restoreGState()
    }
    
    
    @objc open override func drawHighlightLines(context: CGContext, point: CGPoint, set: ILineScatterCandleRadarChartDataSet)
    {
        
        // draw vertical highlight lines
        if set.isVerticalHighlightIndicatorEnabled
        {
            context.beginPath()
            //budget intelligent
            context.move(to: CGPoint(x: point.x, y: viewPortHandler.contentTop + 10))
            
            context.addLine(to: CGPoint(x: point.x, y: viewPortHandler.contentBottom))
            
            context.setStrokeColor(UIColor.red.withAlphaComponent(0.3).cgColor)
            context.setFillColor(UIColor.red.withAlphaComponent(0.3).cgColor)
            context.strokePath()
        }
        
        // draw horizontal highlight lines
        if set.isHorizontalHighlightIndicatorEnabled
        {
            context.beginPath()
            context.move(to: CGPoint(x: viewPortHandler.contentLeft, y: point.y))
            context.addLine(to: CGPoint(x: viewPortHandler.contentRight, y: point.y))
            context.setStrokeColor(UIColor.red.cgColor)
            context.setFillColor(UIColor.red.cgColor)
            context.strokePath()
        }
    }
}






