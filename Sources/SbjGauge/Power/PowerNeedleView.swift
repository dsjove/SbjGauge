//
//  PowerNeedleView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Power {
	public struct NeedleView: View {
		let geom: GeometryProxy
		let radius: Double
		let width: Double
		let color1: Color
		let color2: Color

		public init(
			geom: GeometryProxy,
			radius: Double = 0.660,
			width: Double = 0.055,
			color1: Color = .sbjGauge("Power/Needle1"),
			color2: Color = .sbjGauge("Power/Needle2"),
			alpha: Double = 1.0) {
				self.geom = geom
				self.radius = radius
				self.width = width
				self.color1 = color1.opacity(alpha)
				self.color2 = color2.opacity(alpha)
		}

		public var body: some View {
			let actualRadius = geom.radius(radius)
			let actualWidth = geom.width(width)
			Path { path in
				path.move(to: geom.center(x: actualWidth / 2.0, y: 0))
					path.addArc(
						center: geom.center,
						radius: actualWidth/2,
						startAngle: .degrees(0),
						endAngle: .degrees(90),
						clockwise: false)
				path.addLine(to: geom.center(x: 0, y: -actualRadius))
			}
			.fill(color1)

			Path { path in
				path.move(to: geom.center(x: -actualWidth / 2.0, y: 0))
				path.addArc(
					center: geom.center,
					radius: actualWidth/2,
					startAngle: .degrees(180),
					endAngle: .degrees(90),
					clockwise: true)
				path.addLine(to: geom.center(x: 0, y: -actualRadius))
			}
			.fill(color2)
			ScrewView(geom: geom)
		}
	}
}

#Preview {
	Standard.GeometryView() {
		Power.NeedleView(geom: $0)
	}
}
