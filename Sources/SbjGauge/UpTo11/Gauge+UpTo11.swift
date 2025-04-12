//
//  Gauge+upTo11.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/10/25.
//

import SwiftUI

public extension Gauge {
	enum UpTo11 {
	}

	@ViewBuilder
	static func upTo11(_ value: Double) -> some View {
		let model = Model(upTo11: value)
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

public extension Gauge.Model {
	init(upTo11 value: Double) {
		range = 0 ... 11
		values = [range.clamp(value)]
		angles = .degrees(225) ... .degrees(520)
		tickIncrements = [1]
		tickEnds = .both
	}
}

/*
struct GaugeUpTo11Preview: View {
	@State private var value: CGFloat = 0.0

	var body: some View {
		Gauge.upTo11(value)
			.gesture(
				DragGesture()
					.onChanged { gesture in
					let maxTranslation = max(abs(gesture.translation.width), abs(gesture.translation.height))
						self.value += maxTranslation / 11.0
					}
			)
	}
}
*/
#Preview {
	Gauge.upTo11(11)
}
