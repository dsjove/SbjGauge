//
//  NeedleSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

//TODO: refactor to be a view modifier called "ModelValueRotate" where it applies the transformation to a single view.

extension Standard {
	@ViewBuilder
	public static func defaultNeedle<Value>(geom: GeometryProxy, idx: Int, _: Value) -> some View {
		NeedleView(geom: geom, alpha: idx == 0 ? 1.0 : 0.25)
	}

	public struct NeedleSetView<Model: Values & Radial, Content: View>: View {
		let geom: GeometryProxy
		let model: Model
		let clockwise: Bool
		@ViewBuilder
		let content: (GeometryProxy, Model.ValueIdx, Model.Value) -> Content

		public init(
			geom: GeometryProxy,
			model: Model,
			clockwise: Bool = true,
			@ViewBuilder content: @escaping (GeometryProxy, Int, Double) -> Content = defaultNeedle) {
				self.geom = geom
				self.model = model
				self.clockwise = clockwise
				self.content = content
		}

		public var body: some View {
			ForEach(Array(model.values.enumerated().reversed()), id: \.offset) { (index, value) in
					content(geom, index, value)
//TODO:
// Does the .degrees(360.0) always fix the 'rotate in correct direction'?
// That animation call produced both runtime and compile time warnings.
						.rotationEffect((model.angle(value: value) + .degrees(360.0)) * (clockwise ? 1 : -1))
						.animation(.linear(duration: 0.1))
				}
		}
	}
}

#Preview {
	ZStackSquare() {
		Standard.NeedleSetView(geom: $0, model: FullModel(standard: 3.33))
	}
}
