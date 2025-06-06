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
			Standard.GeometryView() { geom in
				Color.sbjGauge("UpTo11/Background")
				Standard.RadialTickView(geom, model, model.ticks[0],
						radius: 0.7) { notch in
					Standard.TickTextView(geom: geom,
						text: notch.idx.description,
						color: .black)
				}
				Standard.RadialTickView(geom, model, model.ticks[1],
						radius: 0.7) { _ in
					Standard.TickLineView(geom: geom,
						width: 0.008,
						color: .black)
				}
				KnobView(geom: geom)
					.radialRotate(model.needle())
				ShineView(geom: geom)
			}
		}
	}
}

public extension StandardModel {
	init(upTo11 value: Double) {
		self.init(value: value, range: 0 ... 11)

		angles = .degrees(225) ... .degrees(520)
		ticks = [
			.init(1, ends: .closed, filter: { _, inc in inc.isMultiple(of: 2) || inc == 11}),
			.init(1, ends: .closed, filter: { _, inc in !inc.isMultiple(of: 2) && inc != 11}),
		]
	}
}

#Preview {
	UpTo11.UpTo11View()
}
