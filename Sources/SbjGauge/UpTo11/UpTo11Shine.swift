//
//  GuitarAmpKnob.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/10/25.
//

import SwiftUI

public extension Gauge.UpTo11 {
	struct Shine: View {
		let geom: GeometryProxy
		let width: Double

		public var body: some View {
			ZStack {
				Circle()
					.fill(LinearGradient(
					gradient: Gradient(colors: [.gray, .clear]),
					startPoint: .top,
					endPoint: .bottom ))
				.frame(width: geom.width(width), height: geom.width(width))
			}
		}
	}
}

#Preview {
	ZStackSquare(preview: true) {
		Gauge.UpTo11.Shine(geom: $0, width: 0.45)
	}
}
