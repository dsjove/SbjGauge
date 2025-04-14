//
//  NeedleSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	public struct NeedleSetView<Needle: View>: View {
		public typealias Content = (GeometryProxy, Int, Double) -> Needle
		let geom: GeometryProxy
		let model: Model
		let content: Content

		public static var defaultBuilder: (GeometryProxy, Int, Double) -> NeedleView {
			{ geom, idx, _ in
				return NeedleView(geom: geom, alpha: idx == 0 ? 1.0 : 0.25)
			}
		}

		public init(
			geom: GeometryProxy,
			model: Model,
			@ViewBuilder content: @escaping Content = defaultBuilder) {
				self.geom = geom
				self.model = model
				self.content = content
		}

		public var body: some View {
			ForEach(Array(model.values.enumerated().reversed()), id: \.offset) { (index, value) in
					content(geom, index, value)
//TODO:
// Does the .degrees(360.0) always fix the 'rotate in correct direction'?
// That animation call produced both runtime and compile time warnings.
						.rotationEffect(model.angle(value: value) + .degrees(360.0))
						.animation(.linear(duration: 0.1))
				}
		}
	}
}

#Preview {
	ZStackSquare() {
		Standard.NeedleSetView(geom: $0, model: .init(standard: 0))
	}
}
