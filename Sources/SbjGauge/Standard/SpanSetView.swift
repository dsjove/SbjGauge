//
//  SpanSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	@ViewBuilder
	public static func defaultSpan(geom: GeometryProxy, idx: Int, label: String?, angles: ClosedRange<Angle>) -> some View {
		SpanView(geom: geom, label: label, angles: angles)
	}

	public struct SpanSetView<Range: View>: View {
		public typealias Content = (GeometryProxy, Int, String?, ClosedRange<Angle>) -> Range
		let geom: GeometryProxy
		let model: Model
		let content: Content

		public init(
			geom: GeometryProxy,
			model: Model,
			@ViewBuilder content: @escaping Content = defaultSpan
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
		Standard.SpanSetView(geom: $0, model: .init(standard: 0))
	}
}
