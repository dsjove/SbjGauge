//
//  UpTo11Knob.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/10/25.
//

import SwiftUI

public extension UpTo11 {
	struct KnobView: View {
		let geom: GeometryProxy
		let width: Double
		let color1: Color
		let color2: Color

		public init(
			geom: GeometryProxy,
			width: Double = 0.45,
			color1: Color = .black,
			color2: Color = .white) {
				self.geom = geom
				self.width = width
				self.color1 = color1
				self.color2 = color2
		}

		public var body: some View {
			let actualWidth = geom.width(width)
			let tickHeight = actualWidth * 0.333
			let offset = (actualWidth - tickHeight)/2 - actualWidth * 0.03
			Circle()
				.fill(color1)
				.shadow(radius: geom.radius(0.05))
				.frame(width: actualWidth, height: actualWidth)
				.overlay(
					RoundedRectangle(cornerRadius: actualWidth * 0.04)
						.fill(color2)
						.frame(width: actualWidth * 0.08, height: tickHeight)
						.offset(y: -offset)
				)
		}
	}
}

#Preview {
	ZStackSquare() {
		UpTo11.KnobView(geom: $0, width: 0.45)
	}
}
