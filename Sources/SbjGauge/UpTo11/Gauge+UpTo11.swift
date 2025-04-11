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
			Standard.TickSetView(geom: geom, model: model) { geom, _, _, idc, value in
				Standard.TickView(
					geom: geom,
					style: (value == 11 || idc.isMultiple(of: 2)) ? .text(idc.description) : .line(0.008),
					radius: 0.7,
					color: .black)
			}
			Standard.NeedleSetView(geom: geom, model: model) { geom, _, _, _ in
				UpTo11.Knob(geom: geom, width: 0.45)
			}
			UpTo11.Shine(geom: geom, width: 0.45)
		}
	}
}

public extension Gauge.Model {
	init(upTo11 value: Double) {
		range = 0 ... 11
		values = [value]
		angles = .degrees(225) ... .degrees(520)
		tickIncrements = [1]
		tickEnds = .both
	}
}

/*
struct GaugeUpTo11Preview: View {
    @State private var value: CGFloat = 0.0
    
    var body: some View {
		Gauge.upTo11(.degrees(value))
			.gesture(
				DragGesture()
					.onChanged { gesture in
						self.value = (gesture.translation.width - gesture.translation.height) / 4.0
					}
			)
    }
}
*/

#Preview {
	Gauge.upTo11(11)
}
