//
//  TickSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	@ViewBuilder
	public static func defaultTick(geom: GeometryProxy, idx: Int, idc: Int, value: Double) -> some View {
		switch idx {
			case 0:
				TickView(geom: geom)
			case 1:
				TickView(geom: geom,
					style: .text(Int(value).description),
					offset: 0.1,
					length: 0.2)
			default:
				EmptyView()
		}
	}

	public struct TickSetView<Tick: View>: View {
		public typealias Content = (GeometryProxy, Int, Int, Double) -> Tick
		let geom: GeometryProxy
		let model: Model
		let content: Content

		public init(
			geom: GeometryProxy,
			model: Model,
			@ViewBuilder content: @escaping Content = defaultTick) {
				self.geom = geom
				self.model = model
				self.content = content
		}

		public var body: some View {
			ForEach(Array(model.ticks.enumerated().reversed()), id: \.offset) { (idx, tick) in
				ForEach(model.tickValues(tick), id: \.offset) { value in
					content(geom, idx, value.offset, value.element)
						.rotationEffect(model.angle(value: value.element))
				}
			}
		}
	}
}

#Preview {
	ZStackSquare() {
		Standard.TickSetView(geom: $0, model: .init(standard: 0))
	}
}
