//
//  GuitarAmpKnob.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/10/25.
//

import SwiftUI

public extension UpTo11 {
	struct ShineView: View {
		let geom: GeometryProxy
		let width: Double
		let color: Color

		public init(
			geom: GeometryProxy,
			width: Double = 0.45,
			color: Color = .gray) {
				self.geom = geom
				self.width = width
				self.color = color
		}

		public var body: some View {
			Circle()
				.fill(LinearGradient(
					gradient: Gradient(colors: [color, .clear]),
					startPoint: .top,
					endPoint: .bottom ))
				.frame(width: geom.width(width), height: geom.width(width))
		}
	}
}

#Preview {
	Standard.GeometryView() {
		UpTo11.ShineView(geom: $0, width: 0.45)
	}
}
