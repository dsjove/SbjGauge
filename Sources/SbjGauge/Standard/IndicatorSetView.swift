//
//  IndicatorSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	@ViewBuilder
	public static func defaultIndicator(label: String, width: Double, color: Color = .sbjGauge("Standard/Indicator")) -> some View {
		Text(label)
			.foregroundColor(color)
			.minimumScaleFactor(0.5)
			.lineLimit(1)
			.font(.title)
			.truncationMode(.tail)
			.frame(width: width)
	}

	@ViewBuilder
	public static func defaultIndicators(model: Model, width: Double) -> some View {
		defaultIndicator(label: String(format: "%.01f", model.values[0]), width: width)
	}

	public struct IndicatorSetView<Set: View>: View {
		public typealias Content = (Model, Double) -> Set
		let geom: GeometryProxy
		let model: Model
		let radius: Double
		let width: Double
		let content: Content

		public init(
			geom: GeometryProxy,
			model: Model,
			radius: Double = 0.200,
			width: Double = 0.185,
			@ViewBuilder content: @escaping Content = defaultIndicators) {
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
	ZStackSquare() {
		Standard.IndicatorSetView(geom: $0, model: .init(standard: 0)) { _, w in
			Standard.defaultIndicator(label: "H", width: w)
			Standard.defaultIndicator(label: "E", width: w)
			Standard.defaultIndicator(label: "L", width: w)
			Standard.defaultIndicator(label: "L", width: w)
			Standard.defaultIndicator(label: "O", width: w)
		}
	}
}
