//
//  SpanSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	@ViewBuilder
	public static func defaultSpan(geom: GeometryProxy, idx: Int, values: ClosedRange<Double>, angles: ClosedRange<Angle>) -> some View {
		SpanView(geom: geom, label: "(\(values.lowerBound) ... \(values.upperBound))", angles: angles)
	}

	public struct SpanSetView<Range: View>: View {
		public typealias Content = (GeometryProxy, Int, ClosedRange<Double>, ClosedRange<Angle>) -> Range
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
				content(geom, index, span, model.angles(for: span))
			}
		}
	}
}

#Preview {
	ZStackSquare() {
		Standard.SpanSetView(geom: $0, model: {
			var m = Model.init(standard: 0)
			m.spans = [
				0...2.5,
				2.5...5,
				5...7.5,
				7.5...10,
			]
			return m
		}())
	}
}
