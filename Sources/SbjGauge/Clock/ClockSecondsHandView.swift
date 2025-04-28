//
//  ClockSecondsHandView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/8/25.
//

import SwiftUI

public extension Clock {
	struct SecondsHandView: View {
		let geom: GeometryProxy
		let radius: Double
		let width: Double
		let knob: Double
		let color: Color

		public init(
			geom: GeometryProxy,
			radius: Double = 0.9,
			width: Double = 0.01,
			knob: Double = 0.05,
			color: Color = .sbjGauge("Clock/SecondsHand")) {
				self.geom = geom
				self.color = color
				self.radius = radius
				self.width = width
				self.knob = knob
		}

		public var body: some View {
			let radius = geom.radius(radius)
			Rectangle()
				.fill(color)
				.frame(width: geom.width(width), height: radius)
				.offset(y: -radius / 2.0)
			Circle()
				.fill(color)
				.frame(width: geom.width(knob))
		}
	}
}

#Preview {
	GaugeGeometryView() {
		Clock.SecondsHandView(geom: $0)
	}
}
