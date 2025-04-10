//
//  GuitarAmpKnob.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/10/25.
//

import SwiftUI

public extension Gauge.UpTo11 {
	struct GuitarAmpKnob: View {
		let geom: GeometryProxy

		public var body: some View {
			Circle()
				.fill(LinearGradient(
					gradient: Gradient(colors: [.gray, .black]),
					startPoint: .top,
					endPoint: .bottom
				))
				.frame(width: geom.width(0.25), height: geom.width(0.25))
				.shadow(radius: geom.radius(0.0125))

			Rectangle()
				.fill(Color.white)
				.frame(width: geom.width(0.01), height: geom.width(0.075))
				.offset(y: geom.width(-0.0875))
		}
	}
}

#Preview {
	ZStackSquare(preview: true) {
		Gauge.UpTo11.GuitarAmpKnob(geom: $0)
	}
}
