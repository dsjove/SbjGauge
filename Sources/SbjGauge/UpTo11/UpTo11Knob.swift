//
//  UpTo11Knob.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/10/25.
//

import SwiftUI

public extension UpTo11 {
	struct Knob: View {
		let geom: GeometryProxy
		let width: Double

		public var body: some View {
			let actualWidth = geom.width(width)
			let tickHeight = actualWidth * 0.333
			let offset = (actualWidth - tickHeight)/2 - actualWidth * 0.03
			Circle()
				.fill(.black)
				.shadow(radius: geom.radius(0.05))
				.frame(width: actualWidth, height: actualWidth)
				.overlay(
					RoundedRectangle(cornerRadius: actualWidth * 0.04)
						.fill(Color.white)
						.frame(width: actualWidth * 0.08, height: tickHeight)
						.offset(y: -offset)
				)
		}
	}
}

#Preview {
	ZStackSquare() {
		UpTo11.Knob(geom: $0, width: 0.45)
	}
}
