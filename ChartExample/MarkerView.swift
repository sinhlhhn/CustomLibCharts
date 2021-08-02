//
//  MarkerView.swift
//  ChartExample
//
//  Created by Lê Hoàng Sinh on 04/05/2021.
//  Copyright © 2021 Lê Hoàng Sinh. All rights reserved.
//

import Foundation
import Charts

open class BalloonMarker: MarkerImage
{
    @objc open var color: UIColor
    @objc open var arrowSize = CGSize(width: 15, height: 11)
    @objc open var font: UIFont
    @objc open var textColor: UIColor
    @objc open var insets: UIEdgeInsets
    @objc open var minimumSize = CGSize()
    
    fileprivate var label: String? = "Spend by day:"
    fileprivate var _labelSize: CGSize = CGSize()
    fileprivate var label2: String? = "$12"
    fileprivate var _labelSize2: CGSize = CGSize()
    fileprivate var label3: String? = "Total spent:"
    fileprivate var _labelSize3: CGSize = CGSize()
    fileprivate var label4: String? = "$811"
    fileprivate var _labelSize4: CGSize = CGSize()
    fileprivate var label5: String? = "Left:"
    fileprivate var _labelSize5: CGSize = CGSize()
    fileprivate var label6: String? = "$30"
    fileprivate var _labelSize6: CGSize = CGSize()
    
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [NSAttributedString.Key : Any]()
    fileprivate var _drawValueAttributes = [NSAttributedString.Key : Any]()
    
    @objc public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets)
    {
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .center
        super.init()
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
        var offset = self.offset
        var size = self.size

        if size.width == 0.0 && image != nil
        {
            size.width = image!.size.width
        }
        if size.height == 0.0 && image != nil
        {
            size.height = image!.size.height
        }

        let width = size.width
        let height = size.height
        let padding: CGFloat = 8.0

        var origin = point
        origin.x -= width / 2
        origin.y -= height

        if origin.x + offset.x < 0.0
        {
            offset.x = -origin.x + padding
        }
        else if let chart = chartView,
            origin.x + width + offset.x > chart.bounds.size.width
        {
            offset.x = chart.bounds.size.width - origin.x - width - padding
        }

        if origin.y + offset.y < 0
        {
            offset.y = height + padding;
        }
        else if let chart = chartView,
            origin.y + height + offset.y > chart.bounds.size.height
        {
            offset.y = chart.bounds.size.height - origin.y - height - padding
        }

        return offset
    }
    
    open override func draw(context: CGContext, point: CGPoint)
    {
        guard let label = label,
              let label2 = label2,
              let label3 = label3,
              let label4 = label4,
              let label5 = label5,
              let label6 = label6 else { return }
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        var rect = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
                y: point.y + offset.y),
            size: size)
        rect.origin.x -= size.width / 2.0
        rect.origin.y -= size.height
        
        context.saveGState()

        context.setFillColor(color.cgColor)
        
        
        
        if offset.y > 0
        {
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + arrowSize.height))
            context.fillPath()
        }
        else
        {
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.fillPath()
        }
        
        if offset.y > 0 {
            rect.origin.y += self.insets.top + arrowSize.height
        } else {
            rect.origin.y += self.insets.top
        }

        rect.size.height -= self.insets.top + self.insets.bottom
        
        UIGraphicsPushContext(context)

        rect.size.width = _labelSize.width
        rect.origin.x += self.insets.left
        
        let rect2 = CGRect(x: rect.origin.x + _labelSize.width + 4,
                           y: rect.origin.y,
                           width: _labelSize2.width,
                           height: rect.height)
        
        let rect3 = CGRect(x: rect.origin.x,
                           y: rect.origin.y + _labelSize2.height,
                           width: _labelSize3.width ,
                           height: rect.height)
        
        let rect4 = CGRect(x: rect3.origin.x + _labelSize3.width + 4,
                           y: rect3.origin.y,
                           width: _labelSize4.width,
                           height: rect.height)
        
        let rect5 = CGRect(x: rect3.origin.x,
                           y: rect3.origin.y + _labelSize4.height,
                           width: _labelSize5.width,
                           height: rect.height)
        
        let rect6 = CGRect(x: rect5.origin.x + _labelSize5.width + 4,
                           y: rect5.origin.y,
                           width: _labelSize6.width,
                           height: rect.height)
        
        
        label.draw(in: rect, withAttributes: _drawAttributes)
        label2.draw(in: rect2, withAttributes: _drawValueAttributes)
        label3.draw(in: rect3, withAttributes: _drawAttributes)
        label4.draw(in: rect4, withAttributes: _drawValueAttributes)
        label5.draw(in: rect5, withAttributes: _drawAttributes)
        label6.draw(in: rect6, withAttributes: _drawValueAttributes)
        
        
        print("rect1: ", rect)
        print("rect2: ", rect2)
        print("rect3: ", rect3)
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        setLabel(label!,label2!, label3!, label4!, label5!, label6!)
    }
    
    @objc open func setLabel(_ newLabel: String,_ newLabel2: String, _ newLabel3: String, _ newLabel4: String, _ newLabel5: String, _ newLabel6: String)
    {
        label = newLabel
        label2 = newLabel2
        label3 = newLabel3
        label4 = newLabel4
        label5 = newLabel5
        label6 = newLabel6
        
        _drawAttributes.removeAll()
        _drawAttributes[.font] = UIFont.systemFont(ofSize: 14, weight: .medium)
        _drawAttributes[.paragraphStyle] = _paragraphStyle
        _drawAttributes[.foregroundColor] = self.textColor
        
        _drawValueAttributes.removeAll()
        _drawValueAttributes[.font] = UIFont.systemFont(ofSize: 14, weight: .bold)
        _drawValueAttributes[.paragraphStyle] = _paragraphStyle
        _drawValueAttributes[.foregroundColor] = self.textColor
        
        _labelSize = label?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        _labelSize2 = label2?.size(withAttributes: _drawValueAttributes) ?? CGSize.zero
        _labelSize3 = label3?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        _labelSize4 = label4?.size(withAttributes: _drawValueAttributes) ?? CGSize.zero
        _labelSize5 = label5?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        _labelSize6 = label6?.size(withAttributes: _drawValueAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = max(_labelSize.width + _labelSize2.width, _labelSize3.width + _labelSize4.width, _labelSize5.width + _labelSize6.width) + self.insets.left + self.insets.right
        
        size.height = _labelSize2.height * 3  + self.insets.top + self.insets.bottom + arrowSize.height
        
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
        
        print("labelSize: ",_labelSize)
        print("labelSize2: ",_labelSize2)
        print("labelSize3: ",_labelSize3)
        
        print("width: ",size.width)
        print("height: ",size.height)
        
        
    }
    
}
