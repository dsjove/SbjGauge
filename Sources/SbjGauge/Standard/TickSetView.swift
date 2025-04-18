//
//  TickSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	public struct TickNotch {
		public let idx: Int
		public let idc: Int
		public let count: Int
		public let value: Double
	}
	@ViewBuilder
	public static func defaultTick(geom: GeometryProxy, notch: TickNotch) -> some View {
		switch notch.idx {
			case 0:
				TickView(geom: geom)
			case 1:
				TickView(geom: geom,
					style: .text(Int(notch.value).description),
					offset: 0.1,
					length: 0.2)
			default:
				EmptyView()
		}
	}

	public struct TickSetView<Model: Values & Radial & Ticking, Content: View>: View {
		let geom: GeometryProxy
		let model: Model
		@ViewBuilder
		let content: (GeometryProxy, TickNotch) -> Content

		public init(
			geom: GeometryProxy,
			model: Model,
			@ViewBuilder content: @escaping (GeometryProxy, TickNotch) -> Content = defaultTick) {
				self.geom = geom
				self.model = model
				self.content = content
		}

		public var body: some View {
			ForEach(Array(model.ticks.enumerated().reversed()), id: \.offset) { (idx, tick) in
				let notches = model.tickAngles(tick)
				let count = notches.count
				ForEach(notches, id: \.offset) { value in
					content(geom,
						.init(idx: idx, idc: value.offset, count: count, value: value.element))
						.rotationEffect(value.angle)
				}
			}
		}
	}
}

#Preview {
	ZStackSquare() {
		Standard.TickSetView(geom: $0, model: FullModel(standard: 0))
	}
}
