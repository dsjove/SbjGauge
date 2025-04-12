//
//  Standard.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/3/25.
//

import SwiftUI

public extension Gauge {
	struct Standard : View {
		let model: Model

		public init(_ model: Model = .init(standard: 0)) {
			self.model = model
		}

		public var body: some View {
			ZStackSquare() { geom in
				BackgroundView(geom: geom)
				TickSetView(geom: geom, model: model)
				SpanSetView(geom: geom, model: model)
				NeedleSetView(geom: geom, model: model)
				RimView(geom: geom)
			}
		}
	}
}

public extension Gauge.Model {
	init(standard value: Double, range: ClosedRange<Double> = 0 ... 10) {
		self.values = [value]
		self.range = range
	}
}

#Preview {
	Gauge.Standard(.init(standard: 1.5))
}
