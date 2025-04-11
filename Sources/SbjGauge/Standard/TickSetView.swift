//
//  TickSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Gauge.Standard {
	public struct TickSetView<Tick: View>: View {
		public typealias Content = (GeometryProxy, Gauge.Model, Int, Int, Double) -> Tick
		let geom: GeometryProxy
		let model: Gauge.Model
		let content: Content

		public static var defaultBuilder: (GeometryProxy, Gauge.Model, Int, Int, Double) -> TickView {
			{ geom, _, idx, idc, value in
				switch idx {
					case 0:
						TickView(geom: geom)
					case 1:
						TickView(geom: geom, style: .text(Int(value).description), offset: 0.1, length: 0.2)
					default:
						TickView(geom: geom, style: .none)
				}
			}
		}

		public init(
			geom: GeometryProxy,
			model: Gauge.Model,
			@ViewBuilder content: @escaping Content = defaultBuilder) {
				self.geom = geom
				self.model = model
				self.content = content
		}

		public var body: some View {
			ForEach(Array(model.tickIncrements.enumerated().reversed()), id: \.offset) { (idx, increment) in
				if let increment {
					ForEach(model.tickValues(inc: increment), id: \.offset) { value in
						content(geom, model, idx, value.offset, value.element)
							.rotationEffect(model.angle(value.element))
					}
				}
			}
		}
	}
}

#Preview {
	ZStackSquare() {
		Gauge.Standard.TickSetView(geom: $0, model: .init())
	}
}
