//
//  HeaderBackgroundShape.swift
//  
//
//  Created by Raul Batista on 27.12.2023.
//

import SwiftUI

struct HeaderBackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        let width = rect.size.width
        let height = rect.size.height
        let curveHeight: CGFloat = 15
        let curveMaxY = height
        let curveStartY = curveMaxY - curveHeight

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: curveStartY))
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: curveMaxY),
            controlPoint1: CGPoint(x: 0.144 * width, y: curveStartY),
            controlPoint2: CGPoint(x: 0.357 * width, y: curveMaxY)
        )
        path.addCurve(
            to: CGPoint(x: 1 * width, y: curveStartY),
            controlPoint1: CGPoint(x: 0.643 * width, y: curveMaxY),
            controlPoint2: CGPoint(x: 0.856 * width, y: curveStartY)
        )

        path.addLine(to: CGPoint(x: 1 * width, y: 0))

        path.close()

        return Path(path.cgPath)
    }
}
