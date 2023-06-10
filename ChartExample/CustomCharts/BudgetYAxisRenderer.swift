//
//  BudgetYAxisRenderer.swift
//  ChartExample
//
//  Created by Lê Hoàng Sinh on 14/05/2021.
//  Copyright © 2021 Lê Hoàng Sinh. All rights reserved.
//

import Foundation
import Charts

class BudgetYAxisRenderer: YAxisRenderer {
    /// draws the y-labels on the specified x-position
    open override func drawYLabels(
        context: CGContext,
        fixedPosition: CGFloat,
        positions: [CGPoint],
        offset: CGFloat,
        textAlign: NSTextAlignment)
    {
        let yAxis = self.axis
        
        let labelFont = yAxis.labelFont
        let labelTextColor = yAxis.labelTextColor
        
        let from = yAxis.isDrawBottomYLabelEntryEnabled ? 0 : 1
        let to = yAxis.isDrawTopYLabelEntryEnabled ? yAxis.entryCount : (yAxis.entryCount - 1)
        
        let xOffset = yAxis.labelXOffset
        
        for i in stride(from: from, to: to - 1, by: 1)
        {
            let text = yAxis.getFormattedLabel(i)
            
            context.drawText(
                text, at: CGPoint(x: fixedPosition + xOffset, y: positions[i].y + offset),
                align: textAlign,
                attributes: [.font: labelFont, .foregroundColor: labelTextColor]
            )
        }
        
        // budget intelligent
        let text = yAxis.getFormattedLabel(to - 1)
        context.drawText(
            text,
            at: CGPoint(x: fixedPosition + xOffset, y: positions[to - 1].y + offset),
            align: textAlign,
            attributes: [.font: labelFont, .foregroundColor: UIColor.red]
        )
    }
}
