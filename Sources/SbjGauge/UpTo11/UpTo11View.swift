//
//  UpTo11View.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/10/25.
//

import SwiftUI

public enum UpTo11 {
	public struct UpTo11View: View {
		let model: Model

		public init(_ model: Model = .init(upTo11: 11)) {
			self.model = model
		}

		public var body: some View {
			ZStackSquare() { geom in
				Color.sbjGauge("UpTo11/Background")
				Standard.TickSetView(geom: geom, model: model) { geom, idx, idc, _ in
					switch idx {
						case 0:
							Standard.TickView(
								geom: geom,
								style: .text(idc.description),
								radius: 0.7,
								color: .black)
						case 1:
							Standard.TickView(
								geom: geom,
								style: .line(0.008),
								radius: 0.7,
								color: .black)
						default:
							EmptyView()
					}
				}
				Standard.NeedleSetView(geom: geom, model: model) { geom, _, _ in
					KnobView(geom: geom)
				}
				ShineView(geom: geom)
			}
		}
	}
}

public extension Model {
	init(upTo11 value: Double) {
		range = 0 ... 11
		values = [range.clamp(value)]
		angles = .degrees(225) ... .degrees(520)
		ticks = [
			.init(1, filter: { inc, _ in inc.isMultiple(of: 2) || inc == 11}),
			.init(1, filter: { inc, _ in !inc.isMultiple(of: 2) && inc != 11}),
		]
		tickEnds = .both
	}
}

#Preview {
	UpTo11.UpTo11View()
}
