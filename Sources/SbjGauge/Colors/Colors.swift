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
		let model: Model = .init()

		public init() {
		}

		public var body: some View {
			ZStackSquare() { geom in
				Standard.BackgroundView(geom: geom)
				Standard.RadialTickView(geom, model, model.ticks[0], radius: 0.88) { notch in
					Circle()
						.fill(Color.allCases[notch.idx])
					.frame(width: geom.width(0.1))
				}
			}
		}
	}

	struct Model: ValuesModel & RadialModel & TickModel {
		var values: [Int] = [0]
		var range: ClosedRange<Int> = 0...Color.allCases.count
		var angles: ClosedRange<Angle> = .degrees(0) ... .degrees(360)
		var ticks: [Tick<Int>] = [.init(1, ends: .start)]
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
}

#Preview {
	Colors.ColorsView()
}
