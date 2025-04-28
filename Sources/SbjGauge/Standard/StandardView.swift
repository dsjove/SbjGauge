//
//  StandardView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/3/25.
//

import SwiftUI

public enum Standard {
	public struct StandardView : View {
		let model: StandardModel

		public init(_ model: StandardModel = .init(standard: 0)) {
			self.model = model
		}

		public var body: some View {
			GaugeGeometryView() { geom in
				BackgroundView(geom: geom)
				RadialTickView(geom, model, model.ticks[0]) { notch in
					TickLineView(geom: geom)
					TickTextView(geom: geom,
						text: Int(notch.value).description,
						length: 0.2,
						offset: 0.1)
				}
				RadialIndicatorsView(geom: geom, model: model, content: defaultIndicators)
				RadialNeedlesView(geom: geom, model: model) { _ in
					NeedleView(geom: geom)
				}
				RimView(geom: geom)
			}
		}
	}
}

public extension StandardModel {
	init(standard value: Double, range: ClosedRange<Double> = 0 ... 10) {
		self.range = range
		values = [range.clamp(value)]
	}
}

#Preview {
	Standard.StandardView(.init(standard: 1.25))
}
