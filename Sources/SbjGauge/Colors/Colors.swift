//
//  ColorsView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/20/25.
//

import SwiftUI

//TODO: improve
public enum Colors {
	public struct ColorsView: View {
		@State private var model: Model

		let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()

		public init() {
			_model = State(initialValue: .init())
		}

		public var body: some View {
			Standard.GeometryView() { geom in
				Power.BackgroundView(geom: geom, color: Color.allCases[model.value])
				Standard.RadialTickView(geom, model, model.ticks[0], radius: 0.88) { notch in
					Circle()
						.fill(Color.allCases[notch.idx])
						.frame(width: geom.width(0.1))
						.overlay(Text(notch.idx.description).font(.caption).foregroundColor(Color.white))
					if notch.idx == model.value {
						Circle()
							.stroke(Color.allCases[notch.idx].complementary(), lineWidth: geom.width(0.01))
							.frame(width: geom.width(0.1))
					}
				}
			}
			.onReceive(timer) { input in
				model.value += 1
			}
		}
	}

	struct Model: RadialModel {
		var values: [Int] = [0]
		var range: ClosedRange<Int> = 0...Color.allCases.count
		var clampStyle: ClampStyle = .cycleOpenUpper
		var angles: ClosedRange<Angle> = .degrees(0) ... .degrees(360)
		var ticks: [TickSequence<Int>] = [.init(1, ends: .cycleOpenUpper)]
	}
}

extension Color: @retroactive CaseIterable {
	public static var allCases: [Color] {
		return [
			Color.red,
			Color.orange,
			Color.yellow,
			Color.green,
			Color.mint,
			Color.teal,
			Color.cyan,
			Color.blue,
			Color.indigo,
			Color.purple,
			Color.pink,
			Color.brown,
			Color.white,
			Color.gray,
			Color.black,
			//Color.clear,
			//Color.primary,
			//Color.secondary,
		]
	}

	func complementary(alpha: Double? = nil) -> Color {
		// Extract the RGB components of the color
		let uiColor = UIColor(self)
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var opacity: CGFloat = 0

		uiColor.getRed(&red, green: &green, blue: &blue, alpha: &opacity)

		// Calculate the complementary color
		let complementaryRed = 1.0 - red
		let complementaryGreen = 1.0 - green
		let complementaryBlue = 1.0 - blue
		let complementaryOpacity = alpha ?? opacity

		return Color(red: complementaryRed, green: complementaryGreen, blue: complementaryBlue, opacity: complementaryOpacity)
	}
}

#Preview {
	Colors.ColorsView()
}
