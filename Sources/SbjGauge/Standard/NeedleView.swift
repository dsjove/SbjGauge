//
//  NeedleView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/8/25.
//

import SwiftUI

public extension Standard {
	struct NeedleView: View {
		let geom: GeometryProxy
		let radius: Double
		let width: Double
		let color: Color

		public init(
			geom: GeometryProxy,
			radius: Double = 0.7,
			width: Double = 0.025,
			color: Color = .sbjGauge("Standard/Needle"),
			alpha: Double = 1.0) {
				self.geom = geom
				self.radius = radius
				self.width = width
				self.color = color.opacity(alpha)
		}

		public var body: some View {
			let actualRadius = geom.radius(radius)
			let actualWidth = geom.width(width)
			Path { path in
				path.move(to: geom.center(x: actualWidth / -2, y: 0))
				path.addArc(
					center: geom.center,
					radius: actualWidth/2,
					startAngle: .degrees(180),
					endAngle: .degrees(0),
					clockwise: true)
				path.addLine(to: geom.center(x: 0, y: -actualRadius))
			}
			.fill(color)
		}
	}
}

#Preview {
	Standard.GeometryView() {
		Standard.NeedleView(geom: $0)
	}
}
