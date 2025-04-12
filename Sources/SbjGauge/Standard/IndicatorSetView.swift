//
//  IndicatorSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Gauge.Standard {
	public struct IndicatorSetView<Set: View>: View {
		public typealias Content = (Gauge.Model, Double) -> Set
		let geom: GeometryProxy
		let model: Gauge.Model
		let radius: Double
		let width: Double
		let content: Content

		public static var defaultBuilder: (Gauge.Model, Double) -> EmptyView {
			{ _, _ in
				EmptyView()
			}
		}

		public init(
			geom: GeometryProxy,
			model: Gauge.Model,
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
			IndicatorRadialLayout(radius: radius) {
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
		Gauge.Standard.IndicatorSetView(geom: $0, model: .init(standard: 0)) { _, w in
			PreviewIndicatorView(text: "H", width: w)
			PreviewIndicatorView(text: "E", width: w)
			PreviewIndicatorView(text: "L", width: w)
			PreviewIndicatorView(text: "L", width: w)
			PreviewIndicatorView(text: "O", width: w)
		}
	}
}
