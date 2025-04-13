//
//  SpanSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Gauge.Standard {
	public struct SpanSetView<Range: View>: View {
		public typealias Content = (GeometryProxy, Int, String?, ClosedRange<Angle>) -> Range
		let geom: GeometryProxy
		let model: Gauge.Model
		let content: Content

		public static var defaultBuilder: (GeometryProxy, Int, String?, ClosedRange<Angle>) -> SpanView {
			{ geom, idx, label, angles in
				return SpanView(geom: geom, label: label, angles: angles)
			}
		}

		public init(
			geom: GeometryProxy,
			model: Gauge.Model,
			@ViewBuilder content: @escaping Content = defaultBuilder
		) {
			self.geom = geom
			self.model = model
			self.content = content
		}

		public var body: some View {
			ForEach(Array(model.spans.enumerated()), id: \.offset) { (index, span) in
				let angle1 = model.angle(value: Double(span.range.lowerBound))
				let angle2 = model.angle(value: Double(span.range.upperBound))
				content(geom, index, span.label, angle1...angle2)
			}
		}
	}
}

#Preview {
	ZStackSquare() {
		Gauge.Standard.SpanSetView(geom: $0, model: .init(standard: 0))
	}
}
