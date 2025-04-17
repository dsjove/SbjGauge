//
//  SwirlView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import SwiftUI

public struct SwirlView: View {
	let color: Color

	public init(color: Color = Color.red) {
		self.color = color
	}

	public var body: some View {
		GeometryReader { geometry in
			let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)

			Path { path in
				let turns = 10 // Number of spiral turns
				let points = 200 // Number of points in the swirl
				let maxRadius = min(geometry.size.width, geometry.size.height) / 2

				for i in 0..<points {
					let angle = CGFloat(i) / CGFloat(points) * CGFloat(turns) * 2 * .pi
					let radius = maxRadius * CGFloat(i) / CGFloat(points)

					let x = center.x + radius * cos(angle)
					let y = center.y + radius * sin(angle)

					if i == 0 {
						path.move(to: CGPoint(x: x, y: y))
					} else {
						path.addLine(to: CGPoint(x: x, y: y))
					}
				}
			}
			.stroke(color, lineWidth: 2)
		}
	}
}
