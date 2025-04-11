//
//  TickView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Gauge.Standard {
	public struct TickView: View {
		public enum Style {
			case none
			case line(Double = 0.008)
			case text(String)
		}

		let geom: GeometryProxy
		let style: Style
		let outerRadius: Double
		let innerRadius: Double
		let color: Color

		public init(
			geom: GeometryProxy,
			style: Style = .line(),
			radius: CGFloat = 1.0,
			offset: Double = 0.0,
			length: Double = 0.1,
			color: Color = .sbjGauge("Gauge/Standard/Tick")) {
				self.geom = geom
				self.style = style
				self.outerRadius = radius - offset
				self.innerRadius = outerRadius - length
				self.color = color
		}

		public var body: some View {
			let outer = geom.radius(outerRadius)
			let inner = geom.radius(innerRadius)

			switch style {
				case .none:
					EmptyView()
				case .line(let thickness):
					let lineWidth = geom.width(thickness)
					if lineWidth > 0.0 {
						Path { path in
							path.move(to: geom.center(x: 0, y: -outer))
							path.addLine(to: geom.center(x: 0, y: -inner))
						}
						.stroke(color, lineWidth: lineWidth)
					}
				case .text(let value):
					let height = outer - inner
					Text(value)
						.lineLimit(1)
						.font(.system(size: height))
						.foregroundColor(color)
						.offset(y: -outer + height / 2)
			}
		}
	}
}

#Preview {
	ZStackSquare() {
		Gauge.Standard.TickView(geom: $0, style: .line(0.004), radius: 1.0)
	}
}
