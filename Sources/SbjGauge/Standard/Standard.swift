//
//  Standard.swift
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
			ZStackSquare() { geom in
				BackgroundView(geom: geom)
				RadialTickView(geom, model, model.ticks[0]) { _ in
					TickView(geom: geom)
				}
				RadialTickView(geom, model, model.ticks[1], radius: 0.85) { notch in
					TickView(
						geom: geom,
						style: .text(Int(notch.value).description),
						length: 0.2)
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
