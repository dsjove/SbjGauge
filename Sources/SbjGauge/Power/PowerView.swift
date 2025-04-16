//
//  PowerView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

public enum Power {
	@ViewBuilder
	public static func defaultIndicators(model: Model, width: Double) -> some View {
		Standard.defaultIndicator(label: "Power", width: width, color: .sbjGauge("Power/Indicator"))
	}

	/**
	 * Given a gauge model generated with .init(power), render a gauge useful for motor feedback.
	 */
	public struct PowerView<Indicators: View>: View {
		let model: Model
		let indicators: (Model, Double)->Indicators

		public init(
			_ model: Model = .init(power: 0.000, idle: 0.25),
			@ViewBuilder indicators: @escaping (Model, Double)->Indicators = Power.defaultIndicators) {
				self.model = model
				self.indicators = indicators
		}

		public var body: some View {
			ZStackSquare() { geom in
				Power.BackgroundView(geom: geom)
				Standard.TickSetView(geom: geom, model: model) { geom, idx, idc, value in
					let color = colorForSpan(model.span(for: value)?.0)
					switch idx {
						case 0:
							Standard.TickView(
								geom: geom,
								style: .line(0.005), radius: 0.88, length: 0.05, color: color)
						case 1:
							Standard.TickView(geom: geom, radius: 0.88, length: 0.1, color: color)
						case 2:
							Standard.TickView(geom: geom, style: .text(Int(value).description), radius: 0.88, offset: 0.1, length: 0.14, color: .sbjGauge("Power/Tick"))
						default:
							EmptyView()
					}
				}
				Standard.IndicatorSetView(geom: geom, model: model, content: indicators)
				Standard.NeedleSetView(geom: geom, model: model) { geom, idx, value in
					switch idx {
						case 0:
							Power.NeedleView(geom: geom, alpha: 1.0)
						default:
							Power.NeedleView(geom: geom, alpha: 0.33 /  Double(idx))
					}
				}
				Standard.SpanSetView(geom: geom, model: model) { geom, idx, label, angles in
					Standard.SpanView(geom: geom, label: label, angles: angles, color: colorForSpan(idx))
				}
				Standard.RimView(geom: geom)
			}
		}

		func colorForSpan(_ index: Int?) -> Color {
			switch index {
			case 1: return .sbjGauge("Power/SpanNegBackground")
			case 2: return .sbjGauge("Power/SpanPosBackground")
			default: return .sbjGauge("Standard/SpanBackground")
			}
		}
	}
}

public extension Model {
	init(power value: Double, control: Double? = nil, idle: Double = 0.0) {
		let magnitude = 100.0
		range = -magnitude ... magnitude
		angles = .degrees(210) ... .degrees(510)

		let scaledValue = value * magnitude;
		let scaledControl = control.map({ $0 * magnitude }) ?? scaledValue;
		values = [scaledValue, scaledControl]

		ticks = [
			.init(5, filter: { idc, _ in !idc.isMultiple(of: 5)}),
			.init(25),
			.init(25)
		]
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
	Power.PowerView(.init(power: 0.09, control: 0.25, idle: 0.25))
}
