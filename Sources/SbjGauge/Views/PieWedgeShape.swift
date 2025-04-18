//
//  PieWedge.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/18/25.
//

import SwiftUI

public struct PieWedgeShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        
        return path
    }
}

struct PieWedgePreviewView: View {
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 200, height: 200)
            .clipShape(PieWedgeShape(startAngle: .degrees(0), endAngle: .degrees(90)))
    }
}

#Preview {
	PieWedgePreviewView()
}
