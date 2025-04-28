//
//  RadialIndicatorsView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	@ViewBuilder
	public static func defaultIndicator(label: String, width: Double, color: Color = .sbjGauge("Standard/Indicator")) -> some View {
		Circle()
			.stroke(Color.clear)
			.overlay() {
				Text(label)
					.foregroundColor(color)
					.minimumScaleFactor(0.5)
					.lineLimit(1)
					.font(.system(size: width * 0.5))
					}
		.frame(height: width)
	}

	@ViewBuilder
	public static func defaultIndicators<Model: ValuesModel>(model: Model, width: Double)  -> some View where Model.Value == Double {
		defaultIndicator(label: String(format: "%.01f", model.values[0]), width: width)
	}

	public struct RadialIndicatorsView<Model, Content: View>: View {
		let geom: GeometryProxy
		let model: Model
		let radius: Double
		let width: Double
		@ViewBuilder
		let content: (Model, Double) -> Content

		public init(
			geom: GeometryProxy,
			model: Model,
			radius: Double = 0.175,
			width: Double = 0.185,
			@ViewBuilder content: @escaping (Model, Double) -> Content) {
				self.geom = geom
				self.model = model
				self.radius = radius
				self.width = width
				self.content = content
		}

		public var body: some View {
			IndicatorLayout(radius: radius) {
				content(model, geom.width(width))
			}
		}
	}
}

#Preview {
	GaugeGeometryView() {
		Standard.RadialIndicatorsView(geom: $0, model: 99) { m, w in
			Standard.defaultIndicator(label: "H", width: w)
			Standard.defaultIndicator(label: "E", width: w)
			Standard.defaultIndicator(label: "L", width: w)
			Standard.defaultIndicator(label: "L", width: w)
			Standard.defaultIndicator(label: "O", width: w)
			Standard.defaultIndicator(label: m.description, width: w)
		}
	}
}
