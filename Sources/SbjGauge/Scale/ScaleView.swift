//
//  ScaleView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/18/25.
//

import SwiftUI

public enum Scale {
	public struct ScaleView: View {
		let model: FullModel

		public init(_ model: FullModel = .init(scale: 0)) {
			self.model = model
		}

		public var body: some View {
			ZStackSquare() { geom in
				Clock.SecondsHandView(geom: geom)
				Standard.NeedleSetView(geom: geom, model: model, clockwise: false) { geom, _, _ in
					Standard.TickSetView(geom: geom, model: model)
				}
				Standard.IndicatorSetView(geom: geom, model: model) { _, width in
					Standard.defaultIndicator(label: "LB", width: width)
				}
			}
		}
	}
}

public extension FullModel {
	init(scale value: Double) {
		range = 0 ... 400
		values = [value]
		angles = .degrees(210) ... .degrees(510)
		self.ticks = [
			Tick(50),
			Tick(50)
		]
		self.tickEnds = .both
	}
}

#Preview {
	Scale.ScaleView()
}
