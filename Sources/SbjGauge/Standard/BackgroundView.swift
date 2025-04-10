//
//  BackgroundView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/10/25.
//

import SwiftUI

public extension Gauge.Standard {
	struct BackgroundView: View {
		let geom: GeometryProxy
		let color: Color

		public init(
			geom: GeometryProxy,
			color: Color = .sbjGauge("Gauge/Standard/Background")) {
				self.geom = geom
				self.color = color
		}

		public var body: some View {
			Circle().fill(color)
			.frame(width: geom.diameter)
		}
	}
}

#Preview {
	ZStackSquare(preview: true) {
		Gauge.Standard.BackgroundView(geom: $0)
	}
}
