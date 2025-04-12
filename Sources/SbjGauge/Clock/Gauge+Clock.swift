//
//  Gauge+Clock.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

public extension Gauge {
	/**
	 * Given a Swift Date, render the time in a 12 hour analog clock.
	 */
	struct Clock : View {
		let model: Model

		public init(_ model: Model = .init(clock: Date())) {
			self.model = model
		}

		public var body: some View {
			ZStackSquare() { geom in
				Standard.BackgroundView(geom: geom)
				Standard.TickSetView(geom: geom, model: model) { geom, idx, idc, _ in
					switch idx {
						case 0:
							Standard.TickView(geom: geom, style: .text(idc.description), offset: 0.1, length: 0.2, color: .black)
						case 1:
							Standard.TickView(geom: geom, color: .black)
						case 2:
							Standard.TickView(
								geom: geom,
								style: idc.isMultiple(of: 20) ? .none : .line(0.008), length:  0.05, color: .black)
						default:
							Standard.TickView(geom: geom, style: .none)
					}
				}
				Standard.IndicatorSetView(geom: geom, model: model) { model, width in
					let am = model.values[3] ?? 0 < 12
					Text(am ? "AM" : "PM")
						.foregroundColor(.sbjGauge("Gauge/Clock/Indicator"))
						.frame(width: width)
				}
				Standard.NeedleSetView(geom: geom, model: model) { geom, idx, value in
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
				}
				Clock.RimView(geom: geom)
			}
		}
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
		tickEnds = .end
	}
}

struct GaugeClockPreviewView: View {
	let calendar = Calendar.current
	let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
	@State private var currentTime = Date()

	public var body: some View {
		Gauge.Clock(.init(clock: currentTime))
			.onReceive(timer) { input in
				currentTime = input
			}
	}
}

#Preview {
	GaugeClockPreviewView()
}
