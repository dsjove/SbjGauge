//
//  UpTo11View.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/10/25.
//

import SwiftUI

public enum UpTo11 {
	public struct UpTo11View: View {
		let model: StandardModel

		public init(_ model: StandardModel = .init(upTo11: 11)) {
			self.model = model
		}

		public var body: some View {
			ZStackSquare() { geom in
				Color.sbjGauge("UpTo11/Background")
				Standard.RadialTickView(geom, model, model.ticks[0],
						radius: 0.7) { notch in
					Standard.TickView(
						geom: geom,
						style: .text(notch.idx.description),
						color: .black)
				}
				Standard.RadialTickView(geom, model, model.ticks[1],
						radius: 0.7) { _ in
					Standard.TickView(
						geom: geom,
						style: .line(0.008),
						color: .black)
				}
				Standard.RadialNeedlesView(geom: geom, model: model) { _ in
					KnobView(geom: geom)
				}
				ShineView(geom: geom)
			}
		}
	}
}

public extension StandardModel {
	init(upTo11 value: Double) {
		range = 0 ... 11
		values = [range.clamp(value)]
		angles = .degrees(225) ... .degrees(520)
		ticks = [
			.init(1, ends: .both, filter: { _, inc in inc.isMultiple(of: 2) || inc == 11}),
			.init(1, ends: .both, filter: { _, inc in !inc.isMultiple(of: 2) && inc != 11}),
		]
	}
}

#Preview {
	UpTo11.UpTo11View()
}
