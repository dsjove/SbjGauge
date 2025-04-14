//
//  PowerScrewView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Power {
	public struct ScrewView: View {
		let geom: GeometryProxy
		let outerRadius: Double
		let innerRadius: Double
		let outerColor: Color
		let innerColor: Color

		public init(
			geom: GeometryProxy,
			outerRadius: Double = 0.120,
			innerRadius: Double = 0.060,
			outerColor: Color = .sbjGauge("Power/ScrewOuter"),
			innerColor: Color = .sbjGauge("Power/ScrewInner")
			) {
				self.geom = geom
				self.outerRadius = outerRadius
				self.innerRadius = innerRadius
				self.outerColor = outerColor
				self.innerColor = innerColor
		}

		public var body: some View {
			Circle()
				.fill(outerColor)
				.frame(width: geom.radius(outerRadius))
			Circle()
				.fill(innerColor)
				.frame(width: geom.radius(innerRadius))
		}
	}
}

#Preview {
	ZStackSquare() {
		Power.ScrewView(geom: $0)
	}
}
