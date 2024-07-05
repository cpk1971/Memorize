//
//  Pie.swift
//  Memorize
//
//  Created by Charles Kincy on 2024-07-04.
//

import SwiftUI
import CoreGraphics

struct Pie : Shape {
    var startAngle: Angle = .zero
    let endAngle: Angle
    var clockwise: Bool = true
    
    func path(in rect: CGRect) -> Path {
        // alter to compass rose coordinates
        // iOS puts 0º to the right, sorta like polar coordinates
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise) // iOS inverts the meaning of clockwise, as if you're looking outwards from inside the screen
        p.addLine(to: center)
        return p
    }
}

