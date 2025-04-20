//
//  ColorsView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/20/25.
//

import SwiftUI

public enum Colors {
	public struct ColorsView: View {
		let model: Model = .init()

		public init() {
		}

		public var body: some View {
			ZStackSquare() { geom in
				Standard.RadialTickView(geom, model, model.ticks[0]) { notch in
					Rectangle().fill(Color.allCases[notch.idx])
					.frame(width: 10, height: 10)
				}
			}
		}
	}

	struct Model: ValuesModel & RadialModel & TickModel {
		var values: [Int] = [0]
		var range: ClosedRange<Int> = 0...Color.allCases.count
		var angles: ClosedRange<Angle> = .degrees(0) ... .degrees(360)
		var ticks: [Tick<Int>] = [.init(1)]
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
			Color.clear,
			Color.primary,
			Color.secondary,
		]
	}
}

#Preview {
	Colors.ColorsView()
}
