//
//  TickTextView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/20/25.
//

import SwiftUI

//TODO: add alignment param
extension Standard {
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
		Standard.TickTextView(geom: $0, text: "Hi")
	}
}
