//
//  SpanSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Gauge.Standard {
	public struct SpanSetView<Range: View>: View {
		public typealias Builder = (GeometryProxy, Gauge.Model, Int, String?, ClosedRange<Angle>, Double) -> Range
		let geom: GeometryProxy
		let model: Gauge.Model
		let radius: Double
		let builder: Builder

		public static var defaultBuilder: (GeometryProxy, Gauge.Model, Int, String?, ClosedRange<Angle>, Double) -> SpanView {
			{ geom, _, idx, label, angles, radius in
				return SpanView(geom: geom, label: label, angles: angles, radius: radius)
			}
		}

		public init(
			geom: GeometryProxy,
			model: Gauge.Model,
			radius: Double = 0.97,
			@ViewBuilder builder: @escaping Builder = defaultBuilder
		) {
			self.geom = geom
			self.model = model
			self.radius = radius
			self.builder = builder
		}

		public var body: some View {
			ForEach(Array(model.spans.enumerated()), id: \.offset) { (index, span) in
				if let span {
					let angle1 = model.angle(Double(span.range.lowerBound))
					let angle2 = model.angle(Double(span.range.upperBound))
					builder(geom, model, index, span.label, angle1...angle2, radius)
				}
			}
		}
	}
}

#Preview {
	ZStackSquare(preview: true) {
		Gauge.Standard.SpanSetView(geom: $0, model: .init())
	}
}
