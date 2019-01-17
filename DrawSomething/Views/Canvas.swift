//
//  Canvas.swift
//  DrawSomething
//
//  Created by Raghu Sairam on 17/01/19.
//  Copyright © 2019 Raghu Sairam. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    fileprivate var lines = [Line]()
    
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth:CGFloat = 1
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            context.setStrokeColor(line.strokeColor.cgColor)
            context.setLineWidth(line.strokeWidth)
            context.setLineCap(.round)
            for (i,p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeColor: strokeColor, strokeWidth: strokeWidth, points: []))
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        guard var lastLine = lines.popLast() else {return}
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    func setStrokeWidth(width: CGFloat) {
        self.strokeWidth = width
    }
}
