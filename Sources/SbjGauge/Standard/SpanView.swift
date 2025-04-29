//
//  SpanView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	public struct SpanView: View {
		let geom: GeometryProxy
		let label: String?
		let angles: ClosedRange<Angle>
		let outerRadius: Double
		let innerRadius: Double
		let color: Color
		let textColor: Color

		public init(
			geom: GeometryProxy,
			label: String?,
			angles: ClosedRange<Angle>,
			radius: CGFloat = 0.97,
			width: Double = 0.07,
			color: Color = .sbjGauge("Standard/SpanBackground"),
			textColor: Color = .sbjGauge("Standard/SpanLabel")) {
				self.geom = geom
				self.label = label
				self.angles = angles
				self.outerRadius = radius
				self.innerRadius = radius - width
				self.color = color
				self.textColor = textColor
		}

		public var body: some View {
			if angles.lowerBound == angles.upperBound {
				EmptyView()
			}
			else {
				let radius = geom.radius(outerRadius)
				let lineWidth = radius - geom.radius(innerRadius)
				let angle1 = angles.lowerBound
				let angle2 = angles.upperBound
				Path { path in
					path.addArc(
						center: geom.center,
						radius: radius - lineWidth / 2.0,
						startAngle: angle1 - .degrees(90),
						endAngle: angle2 - .degrees(90),
						clockwise: false)
				}
				.stroke(color, lineWidth: lineWidth)
				if let label {
					let angle3 = angle1 + (angle2 - angle1) / 2.0
					CircleTextView(
						text: label,
						angle: angle3, tooFar: angle2 - angle1)
							.font(.system(size: lineWidth * 0.8))
							.foregroundColor(textColor)
							.frame(width: radius*2, height: radius * 2)
				}
			}
		}
	}
}

#Preview {
	Standard.GeometryView() {
		Standard.SpanView(
			geom: $0,
			label: "Hello",
			angles: Angle.degrees(40) ... Angle.degrees(100))
	}
}
