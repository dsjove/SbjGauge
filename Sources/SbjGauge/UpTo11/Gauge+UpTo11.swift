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
	static func upTo11(preview: Bool = false, _ value: Double = 11) -> some View {
		return Gauge.CompositionView(
				preview: preview,
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
					UpTo11.GuitarAmpKnob(geom: geom)
				},
				foreground: { _, _ in EmptyView()
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

#Preview {
	Gauge.upTo11(preview: true)
}
