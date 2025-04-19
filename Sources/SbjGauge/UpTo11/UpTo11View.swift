//
//  UpTo11View.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/10/25.
//

import SwiftUI

public enum UpTo11 {
	public struct UpTo11View: View {
		let model: FullModel

		public init(_ model: FullModel = .init(upTo11: 11)) {
			self.model = model
		}

		public var body: some View {
			ZStackSquare() { geom in
				Color.sbjGauge("UpTo11/Background")
				Standard.RadialTickView(geom, model, model.ticks[0]) { notch in
					Standard.TickView(
						geom: geom,
						style: .text(notch.idx.description),
						radius: 0.7,
						color: .black)
				}
				Standard.RadialTickView(geom, model, model.ticks[1]) { _ in
					Standard.TickView(
						geom: geom,
						style: .line(0.008),
						radius: 0.7,
						color: .black)
				}
				Standard.NeedleSetView(geom: geom, model: model) { geom, _, _ in
					KnobView(geom: geom)
				}
				ShineView(geom: geom)
			}
		}
	}
}

public extension FullModel {
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
