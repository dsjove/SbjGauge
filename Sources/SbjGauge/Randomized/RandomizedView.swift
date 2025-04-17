//
//  RandomizedView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import SwiftUI

public enum Randomized {
	public struct RandomizedView : View {
		@State private var model: Model = .init(random: 0)

		@State private var background: BackGround = .standard
		@State private var backgroundColor: Int = 3

		@State private var foreground: Foreground = .standard
		@State private var foregoundColor: Int = 2

		@State private var needle: Int = 1
		@State private var needleLength: Double = 0.75
		@State private var needleColor: Int = 1

		private func randomize() {
			background = BackGround.allCases.randomElement()!
			backgroundColor = Int.random(in: 0..<colors.count)

			foreground = Foreground.allCases.randomElement()!
			foregoundColor = Int.random(in: 0..<colors.count)

			needle = Int.random(in: 0...3)
			needleLength = Double.random(in: 0...1)
			needleColor = Int.random(in: 0..<colors.count)
		}

		let colors = [
			Color.clear,
			Color.black,
			Color.gray,
			Color.white,
			Color.red,
			Color.orange,
			Color.yellow,
			Color.green,
			Color.blue,
			Color.indigo,
			Color.purple
		]

		enum BackGround: CaseIterable {
			case none
			case standard
			case power
		}

		@ViewBuilder
		func backgroundView(_ geom: GeometryProxy) -> some View {
			switch background {
			case .none:
				EmptyView()
			case .standard:
				Standard.BackgroundView(geom: geom, color: colors[backgroundColor])
			case .power:
				Power.BackgroundView(geom: geom, color: colors[backgroundColor])
			}
		}

		enum Foreground: CaseIterable {
			case none
			case standard
			case clock
			case upTo11
		}

		@ViewBuilder
		func foregroundView(_ geom: GeometryProxy) -> some View {
			switch foreground {
			case .none:
				EmptyView()
			case .standard:
				Standard.RimView(geom: geom, color: colors[foregoundColor])
			case .clock:
				Clock.RimView(geom: geom, color: colors[foregoundColor])
			case .upTo11:
				UpTo11.ShineView(geom: geom, width: 1.0, color: colors[foregoundColor])
			}
		}

		public init() {
		}

		public var body: some View {
			SbjGauge.ZStackSquare() { geom in
				backgroundView(geom)
				SbjGauge.Standard.TickSetView(geom: geom, model: model)
				SbjGauge.Standard.SpanSetView(geom: geom, model: model)
				SbjGauge.Standard.IndicatorSetView(geom: geom, model: model)
				SbjGauge.Standard.NeedleSetView(geom: geom, model: model) { geom, _, _ in
					switch needle {
						case 0:
							SbjGauge.Standard.NeedleView(geom: geom, radius: needleLength, color: colors[needleColor])
						case 1:
							SbjGauge.Power.NeedleView(geom: geom, radius: needleLength, color1: colors[needleColor])
						case 2:
							SbjGauge.Clock.SecondsHandView(geom: geom, radius: needleLength, color: colors[needleColor])
						case 3:
							SbjGauge.UpTo11.KnobView(geom: geom, width: needleLength)
						default:
							EmptyView()
					}
				}
				foregroundView(geom)
			}
			.onTapGesture {
				randomize()
			}
		}
	}
}

extension SbjGauge.Model {
	init(random seed: Int) {
		self.init(value: 1.5)
	}
}

