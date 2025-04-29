//
//  PowerView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

public enum Power {
	@ViewBuilder
	public static func defaultIndicators(model: StandardModel, width: Double) -> some View {
		Standard.defaultIndicator(label: "Power", width: width, color: .sbjGauge("Power/Indicator"))
	}

	/**
	 * Given a gauge model generated with .init(power), render a gauge useful for motor feedback.
	 */
	public struct PowerView<Indicators: View>: View {
		let model: StandardModel
		let indicators: (StandardModel, Double)->Indicators

		public init(
			_ model: StandardModel = .init(power: 0.000, idle: 0.25),
			@ViewBuilder indicators: @escaping (StandardModel, Double)->Indicators = Power.defaultIndicators) {
				self.model = model
				self.indicators = indicators
		}

		public var body: some View {
			Standard.GeometryView() { geom in
				Power.BackgroundView(geom: geom)
				Standard.RadialTickView(geom, model, model.ticks[0], radius: 0.9) { notch in
					let color = colorForSpan(model.span(for: notch.value)?.0)
					Standard.TickLineView(geom: geom,
						width: 0.005,
						length: 0.05,
						color: color)
				}
				Standard.RadialTickView(geom, model, model.ticks[1], radius: 0.9) { notch in
					let color = colorForSpan(model.span(for: notch.value)?.0)
					Standard.TickLineView(geom: geom,
						length: 0.1,
						color: color)
					Standard.TickTextView(geom: geom,
						text: Int(notch.value).description,
						 length: 0.14,
						 offset: 0.1,
						 color: .sbjGauge("Power/Tick"))
				}
				Standard.RadialIndicatorsView(geom: geom, model: model, content: indicators)
				Standard.RadialNeedlesView(geom: geom, model: model) { needle in
					switch needle.idx {
						case 0:
							Power.NeedleView(geom: geom, alpha: 1.0)
						default:
							Power.NeedleView(geom: geom, alpha: 0.33 /  Double(needle.idx))
					}
				}
				Standard.RadialSpanningView(geom: geom, model: model) { spanArc in
					Standard.SpanView(
						geom: geom,
						label: stringForSpan(spanArc.idx),
						angles: spanArc.angles,
						color: colorForSpan(spanArc.idx))
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

		func stringForSpan(_ index: Int?) -> String {
			switch index {
			case 1: return "Reverse"
			case 2: return "Forward"
			default: return "Idle"
			}
		}
	}
}

public extension StandardModel {
	init(power value: Double, control: Double? = nil, idle: Double = 0.0) {
		let magnitude = 100.0
		range = -magnitude ... magnitude
		angles = .degrees(210) ... .degrees(510)

		let scaledValue = value * magnitude;
		let scaledControl = control.map({ $0 * magnitude }) ?? scaledValue;
		values = [scaledValue, scaledControl]

		ticks = [
			.init(5, ends: .both, filter: { _, idc in !idc.isMultiple(of: 5)}),
			.init(25, ends: .both),
		]

		let scaledIdle = idle * magnitude;
		spans = [
			.init(-scaledIdle ... scaledIdle),
			.init(-magnitude ... -scaledIdle),
			.init(scaledIdle ... magnitude),
		]
	}
}

#Preview {
	Power.PowerView(.init(power: 0.09, control: 0.25, idle: 0.25))
}
