//
//  TickView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	public struct TickView: View {
		public enum Style {
			case line(Double = 0.008)
			case text(String)
		}

		let geom: GeometryProxy
		let style: Style
		let length: Double
		let color: Color

		public init(
			geom: GeometryProxy,
			style: Style = .line(),
			length: Double = 0.1,
			color: Color = .sbjGauge("Standard/Tick")) {
				self.geom = geom
				self.style = style
				self.length = length
				self.color = color
		}

		public var body: some View {
			let height = geom.radius(length)
			switch style {
				case .line(let thickness):
					let lineWidth = geom.width(thickness)
					if lineWidth > 0.0 {
						Path { path in
							path.move(to: geom.center(x: 0, y: 0))
							path.addLine(to: geom.center(x: 0, y: height))
						}
						.stroke(color, lineWidth: lineWidth)
					}
				case .text(let value):
					let height = geom.radius(length)
					Text(value)
						.lineLimit(1)
						.font(.system(size: height))
						.offset(y: height/2)
						.foregroundColor(color)
			}
		}
	}
}

#Preview {
	ZStackSquare() {
		Standard.TickView(geom: $0, style: .line(0.004))
	}
	ZStackSquare() {
		Standard.TickView(geom: $0, style: .text("Hi"))
	}
}
