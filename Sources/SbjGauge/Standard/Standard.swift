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
				RadialTickView(geom, model, model.ticks[0]) { _ in
					TickView(geom: geom)
				}
				RadialTickView(geom, model, model.ticks[1]) { notch in
					TickView(
						geom: geom,
						style: .text(Int(notch.value).description),
						offset: 0.1,
						length: 0.2)
				}
				IndicatorSetView(geom: geom, model: model)
				RadialNeedlesView(geom: geom, model: model) { _ in
					NeedleView(geom: geom)
				}
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
