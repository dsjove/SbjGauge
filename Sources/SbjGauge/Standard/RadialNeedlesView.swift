//
//  RadialNeedlesView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	public struct RadialNeedlesView<Model: ValuesModel & RadialModel, Content: View>: View {
		let geom: GeometryProxy
		let model: Model
		let clockwise: Bool
		@ViewBuilder
		let content: (Needle<Model.Value>) -> Content

		public init(
			geom: GeometryProxy,
			model: Model,
			clockwise: Bool = true,
			@ViewBuilder content: @escaping (Needle<Model.Value>) -> Content) {
				self.geom = geom
				self.model = model
				self.clockwise = clockwise
				self.content = content
			}

		public var body: some View {
			ForEach(Array(model.needles().reversed()), id: \.idx) { needle in
					content(needle)
//TODO:
// Does the .degrees(360.0) always fix the 'rotate in correct direction'?
// That animation call produced both runtime and compile time warnings.
						.rotationEffect((needle.angle + .degrees(360.0)) * (clockwise ? 1 : -1))
						.animation(.linear(duration: 0.1))
				}
		}
	}
}

#Preview {
	ZStackSquare() { geom in
		Standard.RadialNeedlesView(geom: geom, model: StandardModel(standard: 3.33)) { _ in
			Standard.NeedleView(geom: geom)
		}
	}
}
