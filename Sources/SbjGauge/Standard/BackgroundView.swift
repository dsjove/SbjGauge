//
//  BackgroundView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/10/25.
//

import SwiftUI

public extension Standard {
	struct BackgroundView: View {
		let geom: GeometryProxy
		let width: Double
		let color: Color

		public init(
			geom: GeometryProxy,
			width: Double = 1.0,
			color: Color = .sbjGauge("Standard/Background")) {
				self.geom = geom
				self.width = width
				self.color = color
		}

		public var body: some View {
			Circle().fill(color)
				.frame(width: geom.width(width))
		}
	}
}

#Preview {
	ZStackSquare() {
		Standard.BackgroundView(geom: $0)
	}
}
