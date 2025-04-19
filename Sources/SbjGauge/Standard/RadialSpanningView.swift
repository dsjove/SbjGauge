//
//  RadialSpanningView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	public struct RadialSpanningView<Model: RadialModel & SpanningModel, Content: View>: View {
		let geom: GeometryProxy
		let model: Model
		@ViewBuilder
		let content: (SpanArc<Model.Value>) -> Content

		public init(
			geom: GeometryProxy,
			model: Model,
			@ViewBuilder content: @escaping (SpanArc<Model.Value>) -> Content) {
			self.geom = geom
			self.model = model
			self.content = content
		}

		public var body: some View {
			ForEach(Array(model.spanArcs()), id: \.idx) { spanArc in
				content(spanArc)
			}
		}
	}
}

#Preview {
	ZStackSquare() { geom in
		Standard.RadialSpanningView(geom: geom, model: {
			var m = FullModel(standard: 0)
			m.spans = [
				.init(0...2.5),
				.init(2.5...5),
				.init(5...7.5),
				.init(7.5...10),
			]
			return m
		}()) { spanArc in
			Standard.SpanView(geom: geom, label: "\(Int(spanArc.range.lowerBound)) ... \(Int(spanArc.range.upperBound))", angles: spanArc.angles)
		}
	}
}
