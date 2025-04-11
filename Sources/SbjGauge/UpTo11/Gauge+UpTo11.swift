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
}

public extension Gauge {
	static func upTo11(_ value: Double = 11) -> some View {
		return Gauge.CompositionView(
				.init(upTo11: value),
				background: { _, _ in Color(red: 0.76, green: 0.60, blue: 0.42) },
				tickRadius: 0.7,
				tick: { geom, _, idx, idc, radius, value in
					Standard.TickView(
						geom: geom,
						style: (((idc + 2) % 2) != 0) && value != 11 ? .line(0.008) : .text(idc.description),
						radius: radius,
						color: .black)
				},
				needle: { geom, _, _, _ in
					UpTo11.Knob(geom: geom, width: 0.45)
				},
				foreground: { geom, _ in
					UpTo11.Shine(geom: geom, width: 0.45)
				}
			)
	}
}

public extension Gauge.Model {
	init(upTo11 value: Double = 11) {
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
	Gauge.upTo11()
}
