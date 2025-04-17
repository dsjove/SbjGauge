//
//  Standard.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/3/25.
//

import SwiftUI

public enum Standard {
	public struct StandardView : View {
		let model: FullModel

		public init(_ model: FullModel = .init(standard: 0)) {
			self.model = model
		}

		public var body: some View {
			ZStackSquare() { geom in
				BackgroundView(geom: geom)
				TickSetView(geom: geom, model: model)
				SpanSetView(geom: geom, model: model)
				IndicatorSetView(geom: geom, model: model)
				NeedleSetView(geom: geom, model: model)
				RimView(geom: geom)
			}
		}
	}
}

public extension FullModel {
	init(standard value: Double, range: ClosedRange<Double> = 0 ... 10) {
		self.range = range
		values = [range.clamp(value)]
	}
}

#Preview {
	Standard.StandardView(.init(standard: 1.25))
}
