//
//  BudgetCombineChartView.swift
//  ChartExample
//
//  Created by Lê Hoàng Sinh on 15/05/2021.
//  Copyright © 2021 Lê Hoàng Sinh. All rights reserved.
//

import Foundation
import Charts

class BudgetCombineChartView: CombinedChartView {
    internal var _fillFormatter: FillFormatter!
    
    open override func initialize()
    {
        super.initialize()
        
        self.highlighter = CombinedHighlighter(chart: self, barDataProvider: self)
        
        // Old default behaviour
        self.highlightFullBarEnabled = true
        
        _fillFormatter = DefaultFillFormatter()
        
    }
    
    open override var data: ChartData?
    {
        get
        {
            return super.data
        }
        set
        {
            super.data = newValue
            
            self.highlighter = CombinedHighlighter(chart: self, barDataProvider: self)
            
            (renderer as? BudgetCombinedChartRenderer)?.createRenderers()
            renderer?.initBuffers()
        }
    }
}
