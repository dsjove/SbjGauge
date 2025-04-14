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
				Standard.TickSetView(geom: geom, model: model) { geom, _, idc, _ in
					Standard.TickView(
						geom: geom,
						style: (idc == 11 || idc.isMultiple(of: 2)) ? .text(idc.description) : .line(0.008),
						radius: 0.7,
						color: .black)
				}
				Standard.NeedleSetView(geom: geom, model: model) { geom, _, _ in
					Knob(geom: geom, width: 0.45)
				}
				Shine(geom: geom, width: 0.45)
			}
		}
	}
}

public extension Model {
	init(upTo11 value: Double) {
		range = 0 ... 11
		values = [range.clamp(value)]
		angles = .degrees(225) ... .degrees(520)
		tickIncrements = [1]
		tickEnds = .both
	}
}

public struct UpTo11InteractiveView: View {
	@State private var model = Model(upTo11: 11)

	public var body: some View {
		UpTo11.UpTo11View(model)
			.overlay(GeometryReader { geometry in
					Color.clear
						.contentShape(Circle())
						.gesture(
							DragGesture()
								.onChanged { gesture in
									let l1 = gesture.translation.height
									let l2 = gesture.translation.width
									let l = abs(l1) > abs(l2) ? l1 : l2
									model[0] += l / geometry.size.width
								})
			})
	}
}

#Preview {
	UpTo11InteractiveView()
}
