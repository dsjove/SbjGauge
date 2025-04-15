//
//  TickSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	public struct TickSetView<Tick: View>: View {
		public typealias Content = (GeometryProxy, Int, Int, Double) -> Tick
		let geom: GeometryProxy
		let model: Model
		let content: Content

		public static var defaultBuilder: (GeometryProxy, Int, Int, Double) -> TickView {
			{ geom, idx, idc, value in
				switch idx {
					case 0:
						TickView(geom: geom)
					case 1:
						TickView(geom: geom,
							style: .text(Int(value).description),
							offset: 0.1,
							length: 0.2)
					default:
						TickView(geom: geom, style: .none)
				}
			}
		}

		public init(
			geom: GeometryProxy,
			model: Model,
			@ViewBuilder content: @escaping Content = defaultBuilder) {
				self.geom = geom
				self.model = model
				self.content = content
		}

		public var body: some View {
			ForEach(Array(model.ticks.enumerated().reversed()), id: \.offset) { (idx, tick) in
				ForEach(model.tickValues(inc: tick.increment), id: \.offset) { value in
					if tick.filter(value.offset, value.element) {
						content(geom, idx, value.offset, value.element)
							.rotationEffect(model.angle(value: value.element))
					}
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
