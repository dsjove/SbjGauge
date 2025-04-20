//
//  TickView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	public struct TickLineView: View {
		let geom: GeometryProxy
		let width: Double
		let length: Double
		let offset: Double
		let color: Color

		public init(
			geom: GeometryProxy,
			width: Double = 0.008,
			length: Double = 0.1,
			offset: Double = 0.0,
			color: Color = .sbjGauge("Standard/Tick")) {
				self.geom = geom
				self.width = width
				self.length = length
				self.offset = offset
				self.color = color
		}

		public var body: some View {
			let height = geom.radius(length)
			let additional = geom.radius(offset)
			let lineWidth = geom.width(width)
			if lineWidth > 0.0 {
				Path { path in
					path.move(to: geom.center(x: 0, y: additional))
					path.addLine(to: geom.center(x: 0, y: height + additional))
				}
				.stroke(color, lineWidth: lineWidth)
			}
		}
	}

	public struct TickTextView: View {
		let geom: GeometryProxy
		let text: String
		let length: Double
		let offset: Double
		let color: Color

		public init(
			geom: GeometryProxy,
			text: String,
			length: Double = 0.1,
			offset: Double = 0.0,
			color: Color = .sbjGauge("Standard/Tick")) {
				self.geom = geom
				self.text = text
				self.length = length
				self.offset = offset
				self.color = color
		}

		public var body: some View {
			let height = geom.radius(length)
			let additional = geom.radius(offset)
			Text(text)
				.lineLimit(1)
				.font(.system(size: height))
				.offset(y: (height/2) + additional)
				.foregroundColor(color)
		}
	}
}

#Preview {
	ZStackSquare() {
		Standard.TickLineView(geom: $0, width: 0.004)
	}
	ZStackSquare() {
		Standard.TickTextView(geom: $0, text: "Hi")
	}
}
