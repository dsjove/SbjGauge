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
		let clockwise: Bool
		let tick: Tick<Model.Value>
		let radius: Double
		@ViewBuilder
		let content: (TickNotch<Model.Value>) -> Content

		public init(
			_ geom: GeometryProxy,
			_ model: Model,
			clockwise: Bool = true,
			_ tick: Tick<Model.Value>,
			radius: Double = 0.95,
			 @ViewBuilder
			_ content: @escaping (TickNotch<Model.Value>) -> Content) {
				self.geom = geom
				self.model = model
				self.clockwise = clockwise
				self.tick = tick
				self.radius = radius
				self.content = content
		}

		public var body: some View {
			let notches = model.tickNotches(tick)
			ForEach(notches, id: \.idx) { notch in
				content(notch)
			//TODO: have option for rotate but keep orientation
			// - initial reverse rotation around view's intrinsic center
					.offset(CGSize(width: 0.0, height: -geom.radius( radius)))
					.rotationEffect(notch.angle * (clockwise ? 1 : -1))
			}
		}
	}
}

#Preview {
	GaugeGeometryView() { geom in
		Circle().stroke()
		Circle().stroke().frame(width: geom.width(0.8))
		Standard.RadialTickView(geom, StandardModel(standard: 0), .init(1.0), radius: 0.8) { notch in
			Standard.TickLineView(geom: geom,
				width: 0.05,
				offset: -0.1)
			Standard.TickTextView(geom: geom,
				text: "M",
				offset: 0.1)
		}
	}
}
