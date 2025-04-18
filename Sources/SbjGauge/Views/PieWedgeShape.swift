//
//  PieWedge.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/18/25.
//

import SwiftUI

public struct PieWedgeShape: Shape {
	let radius: Double
	let startAngle: Angle
	let endAngle: Angle

	public init(
		radius: Double = 1.0,
		startAngle: Angle,
		endAngle: Angle) {
		self.radius = radius
		self.startAngle = startAngle - .degrees(90)
		self.endAngle = endAngle - .degrees(90)
	}

	public func path(in rect: CGRect) -> Path {
		var path = Path()
		let center = CGPoint(x: rect.midX, y: rect.midY)
		let radius = min(rect.width, rect.height) / 2 * self.radius

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
			.clipShape(PieWedgeShape(
				radius: 0.75,
				startAngle: .degrees(10),
				endAngle: .degrees(90)))
	}
}

#Preview {
	PieWedgePreviewView()
}
