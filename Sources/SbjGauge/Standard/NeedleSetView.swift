//
//  NeedleSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Gauge.Standard {
	public struct NeedleSetView<Needle: View>: View {
		public typealias Content = (GeometryProxy, Gauge.Model, Int, Double) -> Needle
		let geom: GeometryProxy
		let model: Gauge.Model
		let content: Content

		public static var defaultBuilder: (GeometryProxy, Gauge.Model, Int, Double) -> NeedleView {
			{ geom, _, idx, _ in
				return NeedleView(geom: geom, alpha: idx == 0 ? 1.0 : 0.75)
			}
		}

		public init(
			geom: GeometryProxy,
			model: Gauge.Model,
			@ViewBuilder content: @escaping Content = defaultBuilder) {
				self.geom = geom
				self.model = model
				self.content = content
		}

		public var body: some View {
			ForEach(Array(model.values.enumerated().reversed()), id: \.offset) { (index, value) in
				if let value {
					//if index < model.views.needles.count, let item = model.views.needles[index] {
						content(geom, model, index, value)
							.rotationEffect(model.angle(value) + .degrees(360.0))
							.animation(.linear(duration: 0.1))
				}
			}
		}
	}
}

#Preview {
	ZStackSquare() {
		Gauge.Standard.NeedleSetView(geom: $0, model: .init())
	}
}
