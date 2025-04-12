//
//  Gauge+upTo11.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/10/25.
//

import SwiftUI

public extension Gauge {
	struct UpTo11: View {
		let model: Model

		public init(_ model: Model = .init(upTo11: 11)) {
			self.model = model
		}

		public var body: some View {
			ZStackSquare() { geom in
				Color.sbjGauge("Gauge/UpTo11/Background")
				Standard.TickSetView(geom: geom, model: model) { geom, _, idc, _ in
					Standard.TickView(
						geom: geom,
						style: (idc == 11 || idc.isMultiple(of: 2)) ? .text(idc.description) : .line(0.008),
						radius: 0.7,
						color: .black)
				}
				Standard.NeedleSetView(geom: geom, model: model) { geom, _, _ in
					UpTo11.Knob(geom: geom, width: 0.45)
				}
				UpTo11.Shine(geom: geom, width: 0.45)
			}
		}
	}
}

public extension Gauge.Model {
	init(upTo11 value: Double) {
		range = 0 ... 11
		values = [range.clamp(value)]
		angles = .degrees(225) ... .degrees(520)
		tickIncrements = [1]
		tickEnds = .both
	}
}

struct GaugeUpTo11PreviewView: View {
	@State private var model = Gauge.Model(upTo11: 11)

	var body: some View {
		Gauge.UpTo11(model)
			.overlay(GeometryReader { geometry in
					Color.clear // Use a clear background
						.contentShape(Circle())
						.gesture(
							DragGesture()
								.onChanged { gesture in
									let l1 = gesture.translation.height
									let l2 = gesture.translation.width
									let l = abs(l1) > abs(l2) ? l1 : l2
									model[0]? += l / geometry.size.width
								})
			})
	}
}

#Preview {
	GaugeUpTo11PreviewView()
}
