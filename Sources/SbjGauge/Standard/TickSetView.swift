//
//  TickSetView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Gauge.Standard {
	public struct TickSetView<Tick: View>: View {
		public typealias Builder = (GeometryProxy, Gauge.Model, Int, Int, Double, Double) -> Tick
		let geom: GeometryProxy
		let model: Gauge.Model
		let radius: Double
		let builder: Builder

		public static var defaultBuilder: (GeometryProxy, Gauge.Model, Int, Int, Double, Double) -> TickView {
			{ geom, _, idx, idc, radius, value in
				switch idx {
					case 0:
						TickView(geom: geom, radius: radius)
					case 1:
						TickView(geom: geom, style: .text(Int(value).description), radius: radius, offset: 0.1, length: 0.2)
					default:
						TickView(geom: geom, style: .none, radius: radius)
				}
			}
		}

		public init(
			geom: GeometryProxy,
			model: Gauge.Model,
			radius: Double = 0.95,
			@ViewBuilder builder: @escaping Builder = defaultBuilder) {
				self.geom = geom
				self.model = model
				self.radius = radius
				self.builder = builder
		}

		public var body: some View {
			ForEach(Array(model.tickIncrements.enumerated().reversed()), id: \.offset) { (idx, increment) in
				if let increment {
					ForEach(model.tickValues(inc: increment), id: \.offset) { value in
						builder(geom, model, idx, value.offset, radius, value.element)
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
