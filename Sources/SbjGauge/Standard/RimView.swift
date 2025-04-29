//
//  RimView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	public struct RimView: View {
		let geom: GeometryProxy
		let outerRadius: Double
		let innerRadius: Double
		let color: Color

		public init(
			geom: GeometryProxy,
			radius: Double = 1.0,
			offset: Double = 0.0,
			length: Double = 0.03,
			color: Color = .sbjGauge("Standard/Rim")) {
				self.geom = geom
				self.color = color
				self.outerRadius = radius - offset
				self.innerRadius = outerRadius - length
		}

		public var body: some View {
			let radius = geom.radius(outerRadius)
			let lineWidth = radius - geom.radius(innerRadius)
			Circle()
				.strokeBorder(color, lineWidth: lineWidth)
				.frame(width: radius * 2.0)
		}
	}
}

#Preview {
	Standard.GeometryView() {
		Standard.RimView(geom: $0)
	}
}
