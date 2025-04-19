//
//  RadialTickView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	public struct RadialTickView<Model: TickModel & RadialModel, Content: View>: View {
		let geom: GeometryProxy
		let model: Model
		let tick: Tick<Model.Value>
		@ViewBuilder
		let content: (TickNotch<Model.Value>) -> Content

		public init(
			_ geom: GeometryProxy,
			_ model: Model,
			_ tick: Tick<Model.Value>, @ViewBuilder
			_ content: @escaping (TickNotch<Model.Value>) -> Content) {
				self.geom = geom
				self.model = model
				self.tick = tick
				self.content = content
		}

		public var body: some View {
			let notches = model.tickNotches(tick)
			ForEach(notches, id: \.idx) { notch in
				content(notch)
					.rotationEffect(notch.angle)
			}
		}
	}
}

#Preview {
	ZStackSquare() { geom in
		Standard.RadialTickView(geom, StandardModel(standard: 0), .init()) { notch in
			Standard.TickView(geom: geom)
		}
	}
}
