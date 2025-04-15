//
//  IndicatorSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	public struct IndicatorSetView<Set: View>: View {
		public typealias Content = (Model, Double) -> Set
		let geom: GeometryProxy
		let model: Model
		let radius: Double
		let width: Double
		let content: Content

		public static var defaultBuilder: (Model, Double) -> Text {
			{ model, width in
				Text(String(format: "%.01f", model.values[0]))
					.foregroundColor(.sbjGauge("Standard/Tick"))
					//.minimumScaleFactor(0.5) // Allows shrinking down to 50% of the original size
					//.lineLimit(1) // Ensures the text stays on one line
					//.font(.largeTitle)
					//.truncationMode(.tail)
					//.frame(width: width) // Set a fixed width

			}
		}

		public init(
			geom: GeometryProxy,
			model: Model,
			radius: Double = 0.200,
			width: Double = 0.185,
			@ViewBuilder content: @escaping Content = defaultBuilder) {
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

fileprivate struct PreviewIndicatorView: View {
	let text: String
	let width: Double
	var body: some View {
		Circle()
			.stroke(Color.white, lineWidth: 1)
			.frame(width: width, height: width)
			.overlay(
				Text(text)
					.font(.caption)
					.foregroundColor(.white)
			)
	}
}

#Preview {
	ZStackSquare() {
		Standard.IndicatorSetView(geom: $0, model: .init(standard: 0)) { _, w in
			PreviewIndicatorView(text: "H", width: w)
			PreviewIndicatorView(text: "E", width: w)
			PreviewIndicatorView(text: "L", width: w)
			PreviewIndicatorView(text: "L", width: w)
			PreviewIndicatorView(text: "O", width: w)
		}
	}
}
