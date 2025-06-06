//
//  ClockView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

public enum Clock {
	enum Hand: Int {
		case second = 0
		case minute = 1
		case hour = 2
		case hour24 = 3
	}

	public struct ClockView: View {
		let model: StandardModel

		public init(_ model: StandardModel = .init(clock: Date())) {
			self.model = model
		}

		public var body: some View {
			Standard.GeometryView() { geom in
				Standard.BackgroundView(geom: geom)
				Standard.RadialTickView(geom, model, model.ticks[0]) { notch in
					Standard.TickLineView(geom: geom,
						color: .black)
					Standard.TickTextView(geom: geom,
						text: notch.idx.description,
						length: 0.2,
						offset: 0.1,
						color: .black)
				}
				Standard.RadialTickView(geom, model, model.ticks[1]) { _ in
					Standard.TickLineView(geom: geom,
						width: 0.008,
						length: 0.05,
						color: .black)
				}
				Standard.RadialIndicatorsView(geom: geom, model: model) { model, width in
					let am = model[Hand.hour24] < 12
					Standard.defaultIndicator(label: am ? "AM" : "PM", width: width)
				}

				Standard.NeedleView(geom: geom, radius: 0.5, width: 0.04)
					.radialRotate(model.needle(Hand.hour))
				Standard.NeedleView(geom: geom, radius: 0.7, width: 0.025)
					.radialRotate(model.needle(Hand.minute))
				Clock.SecondsHandView(geom: geom)
					.radialRotate(model.needle(Hand.second))

				Clock.RimView(geom: geom)
			}
		}
	}
}

public extension StandardModel {
	init(clock date: Date) {
		let calendar = Calendar.current
		let hour = Double(calendar.component(.hour, from: date))
		let currentHour = hour <= 12 ? hour : hour - 12
		let currentMinute = Double(calendar.component(.minute, from: date))
		let currentSecond = Double(calendar.component(.second, from: date))

		let range = 0 ... 43200.0

		let hourPos = currentHour * 3600.0 + currentMinute * 60.0 + currentSecond
		let minutePos = 12.0 * ((60.0 * currentMinute) + currentSecond)
		let secondPos = 720.0 * currentSecond
		let values = [secondPos, minutePos, hourPos, hour]

		self.init(values: values, range: range)

		ticks = [
			.init(3600, ends: .cycleOpenLower),
			.init(720, ends: .cycleOpenLower, filter: { _, idc in !idc.isMultiple(of: 5)})
		]
	}
}

#Preview {
	Clock.ClockView(.init(clock: Date()))
}
