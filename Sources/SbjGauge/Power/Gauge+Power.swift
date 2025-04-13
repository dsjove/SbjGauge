//
//  Gauge+Power.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

public extension Gauge {
	enum Power {
		@ViewBuilder
		public static func defaultIndicators(model: Model, width: Double) -> some View {
			Text("Power").foregroundColor(.sbjGauge("Gauge/Power/Indicator"))
				.frame(width: width)
		}
	}

	/**
	 * Given a gauge model generated with .init(power), render a gauge useful for motor feedback.
	 */
	@ViewBuilder
	static func power<Indicators: View>(
		_ model: Model,
		@ViewBuilder
		indicators: @escaping (Model, Double)->Indicators = Power.defaultIndicators) -> some View {

		ZStackSquare() { geom in
			Power.BackgroundView(geom: geom)
			Standard.TickSetView(geom: geom, model: model) { geom, idx, idc, value in
				switch idx {
					case 0:
						Standard.TickView(
							geom: geom,
							style: idc.isMultiple(of: 5) ? .none : .line(0.005), radius: 0.88, length: 0.05, color: .sbjGauge("Gauge/Power/Tick"))
					case 1:
						Standard.TickView(geom: geom, radius: 0.88, length: 0.1, color: .sbjGauge("Gauge/Power/Tick"))
					case 2:
						Standard.TickView(geom: geom, style: .text(Int(value).description), radius: 0.88, offset: 0.1, length: 0.14, color: .sbjGauge("Gauge/Power/Tick"))
					default:
						Standard.TickView(geom: geom, style: .none, radius: 0.88, color: .sbjGauge("Gauge/Power/Tick"))
				}
			}
			Standard.IndicatorSetView(geom: geom, model: model, content: indicators)
			Standard.NeedleSetView(geom: geom, model: model) { geom, idx, value in
				switch idx {
					case 0:
						Power.NeedleView(geom: geom, alpha: 1.0)
					default:
						Power.NeedleView(geom: geom, alpha: 0.25)
				}
			}
			Standard.SpanSetView(geom: geom, model: model) { geom, idx, label, angles in
				switch idx {
				case 0:
					Standard.SpanView(geom: geom, label: label, angles: angles)
				case 1:
					Standard.SpanView(geom: geom, label: label, angles: angles, color: .sbjGauge("Gauge/Power/SpanNegBackground"))
				case 2:
					Standard.SpanView(geom: geom, label: label, angles: angles, color: .sbjGauge("Gauge/Power/SpanPosBackground"))
				default:
					Standard.SpanView(geom: geom, label: label, angles: angles)
				}
			}
			Standard.RimView(geom: geom)
		}
	}
}

public extension Gauge.Model {
	init(power value: Double, control: Double? = nil, idle: Double = 0.0) {
		let magnitude = 100.0
		range = -magnitude ... magnitude
		angles = .degrees(210) ... .degrees(510)

		let scaledValue = value * magnitude;
		let scaledControl = control.map({ $0 * magnitude }) ?? scaledValue;
		values = [scaledValue, scaledControl]

		tickIncrements = [5, 25, 25]
		tickEnds = .both

		let scaledIdle = idle * magnitude;
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
