//
//  Gauge+Clock.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

public extension Gauge {
	enum Clock {
	}
}

public extension Gauge {
	/**
	 * Given a swift Date, render the time in a 12 hour analog clock.
	 */
	static func clock(preview: Bool = false, _ date: Date) -> some View {
		return Gauge.CompositionView(
			preview: preview,
			.init(clock: date),
			tick: { geom, _, idx, idc, radius, value in
				switch idx {
					case 0:
						Standard.TickView(geom: geom, style: .text(idc.description), radius: radius, offset: 0.1, length: 0.2, color: .black)
					case 1:
						Standard.TickView(geom: geom, radius: radius, color: .black)
					case 2:
						Standard.TickView(
							geom: geom,
							style: ((idc + 20) % 20) != 0 ? .line(0.008) : .none,
							radius: radius, length:  0.05, color: .black)
					default:
						Standard.TickView(geom: geom, style: .none, radius: radius)
				}
			},
			indicators: { model, _ in
				let am = model.values[3] ?? 0 < 12
				Text(am ? "AM" : "PM")
					.foregroundColor(.sbjGauge("Gauge/Clock/Indicator"))
			},
			needle: { geom, _, idx, value in
				switch idx {
				case 0:
					Clock.SecondsHandView(geom: geom)
				case 1:
					Standard.NeedleView(geom: geom, radius: 0.7, width: 0.025)
				case 2:
					Standard.NeedleView(geom: geom, radius: 0.5, width: 0.04)
				default:
					Standard.NeedleView(geom: geom, alpha: 0.0)
				}
			},
			foreground: {geom, _ in Clock.RimView(geom: geom)})
	}
}

public extension Gauge.Model {
	init(clock date: Date) {
		let calendar = Calendar.current
		let hour = Double(calendar.component(.hour, from: date))
		let currentHour = hour <= 12 ? hour : hour - 12
		let currentMinute = Double(calendar.component(.minute, from: date))
		let currentSecond = Double(calendar.component(.second, from: date))

		range = 0 ... 43200.0

		let hourPos = currentHour * 3600.0 + currentMinute * 60.0 + currentSecond
		let minutePos = 12.0 * ((60.0 * currentMinute) + currentSecond)
		let secondPos = 720.0 * currentSecond
		values = [secondPos, minutePos, hourPos, hour]

		tickIncrements = [3600, 3600, 720]
	}
}

struct GaugeClockPreviewView: View {
	let calendar = Calendar.current
	private let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
	@State private var currentTime = Date()

	public var body: some View {
		Gauge.clock(preview: true, currentTime)
			.onReceive(timer) { input in
				currentTime = input
			}
	}
}

#Preview {
	GaugeClockPreviewView()
}
