//
//  ClockRimView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/9/25.
//

import SwiftUI

public extension Clock {
	struct RimView: View {
		let geom: GeometryProxy
		let color: Color

		public init(
			geom: GeometryProxy,
			color: Color = .sbjGauge("Clock/Rim")) {
				self.geom = geom
				self.color = color
		}

		public var body: some View {
			let thickness = geom.radius(0.05)
			Circle().stroke(
				RadialGradient(
					gradient: Gradient(stops: [
						Gradient.Stop(color: Color.white, location: 0.0), // Inner shine
						Gradient.Stop(color: Color.gray, location: 0.3), // Transition
						Gradient.Stop(color: Color.black.opacity(0.7), location: 0.6), // Outer shadow
						Gradient.Stop(color: Color.gray, location: 0.9) // Edge reflection
					]),
					center: .center,
					startRadius: geom.radius(0.95),
					endRadius: geom.radius(1.0)
				), lineWidth: thickness
			)
			.frame(width: geom.diameter - thickness)
			.colorMultiply(color)
		}
	}
}

#Preview {
	ZStackSquare() {
		Clock.RimView(geom: $0)
	}
}
