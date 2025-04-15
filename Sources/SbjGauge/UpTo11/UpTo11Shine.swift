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

		public var body: some View {
			Circle()
				.fill(LinearGradient(
					gradient: Gradient(colors: [.gray, .clear]),
					startPoint: .top,
					endPoint: .bottom ))
				.frame(width: geom.width(width), height: geom.width(width))
		}
	}
}

#Preview {
	ZStackSquare() {
		UpTo11.ShineView(geom: $0, width: 0.45)
	}
}
