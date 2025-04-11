//
//  Gauge+Power.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

public extension Gauge {
	enum Power {
	}
}

public extension Gauge {
	/**
	 * Given a gauge model generated with .init(power), render a gauge useful for motor feedback.
	 */
	static func power<Indicators: View>(
		_ model: Model,
		indicators: @escaping (Model, Double)->Indicators = {_, _ in
			Text("Power").foregroundColor(.sbjGauge("Gauge/Power/Indicator"))
		}) -> some View {
		return Gauge.CompositionView(
			model,
			background: { geom, _ in
				 Power.BackgroundView(geom: geom, color: .sbjGauge("Gauge/Power/Background"))
			},
			tickRadius: 0.88,
			tick: { geom, _, idx, idc, radius, value in
				switch idx {
				case 0:
					Standard.TickView(
						geom: geom,
						style: ((idc + 5) % 5) != 0 ? .line(0.005) : .none, radius: radius, length: 0.05, color: .sbjGauge("Gauge/Power/Tick"))
				case 1:
					Standard.TickView(geom: geom, radius: radius, length: 0.1, color: .sbjGauge("Gauge/Power/Tick"))
				case 2:
					Standard.TickView(geom: geom, style: .text(Int(value).description), radius: radius, offset: 0.1, length: 0.14, color: .sbjGauge("Gauge/Power/Tick"))
				default:
					Standard.TickView(geom: geom, style: .none, radius: radius, color: .sbjGauge("Gauge/Power/Tick"))
				}
			},
			indicators: indicators,
			needle: { geom, _, idx, value in
				switch idx {
				case 0:
					Power.NeedleView(geom: geom, alpha: 1.0)
				default:
					Power.NeedleView(geom: geom, alpha: 0.25)
				}
			},
			span: { geom, _, idx, label, angles, radius in
				switch idx {
				case 0:
					Standard.SpanView(geom: geom, label: label, angles: angles, radius: radius)
				case 1:
					Standard.SpanView(geom: geom, label: label, angles: angles, radius: radius, color: .sbjGauge("Gauge/Power/SpanNegBackground"))
				case 2:
					Standard.SpanView(geom: geom, label: label, angles: angles, radius: radius, color: .sbjGauge("Gauge/Power/SpanPosBackground"))
				default:
					Standard.SpanView(geom: geom, label: label, angles: angles, radius: radius)
				}
			})
	}
}

public extension Gauge.Model {
	init(power value: Double, control: Double? = nil, idle: Double = 0.0) {
		let magnitude = 100.0
		let scaledValue = value * magnitude;
		let scaledControl = control.map({ $0 * magnitude }) ?? nil;
		let scaledIdle = idle * magnitude;

		range = -magnitude ... magnitude
		values = [scaledValue, scaledControl]

		angles = .degrees(210) ... .degrees(510)

		tickIncrements = [5, 25, 25]
		tickEnds = .both
		spans = [
			.init(-scaledIdle ... scaledIdle, "Idle"),
			.init(-magnitude ... -scaledIdle, "Reverse"),
			.init(scaledIdle ... magnitude, "Forward"),
		]
	}
}

#Preview {
	Gauge.power(.init(power: 0.09, control: 0.25, idle: 0.25))
}
