//
//  ScaleView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/18/25.
//

import SwiftUI

public enum Scale {
	public struct ScaleView: View {
		let model: StandardModel

		public init(_ model: StandardModel = .init(scale: 0)) {
			self.model = model
		}

		public var body: some View {
			ZStackSquare() { geom in
				Standard.BackgroundView(geom: geom)
				Circle()
					.stroke(style: StrokeStyle(lineWidth: 1))
					.frame(width: geom.width(0.8), height: geom.width(0.8))
				Standard.RadialNeedlesView(geom: geom, model: model) { _ in
					Standard.RadialTickView(geom, model, model.ticks[0],
							radius: 0.75) { notch in
						let v = "\(Int((notch.value * 0.453592).rounded(.up)).description)\(notch.idx == 0 ? "kg" : "")"
						Standard.TickView(
							geom: geom,
							style: .text(v),
							length: notch.idx == notch.count-1 ? 0.075 : 0.1)
					}
					Standard.RadialTickView(geom, model, model.ticks[1],
							radius: 0.95) { notch in
						let v = "\(Int(notch.value).description)\(notch.idx == 0 ? "lb" : "")"
						Standard.TickView(
							geom: geom,
							style: .text(v))
					}
				}
				Standard.NeedleView(geom: geom, radius: 1.0, color: Color.red)
			}
			.clipShape(PieWedgeShape(
				startAngle: .degrees(-45),
				endAngle: .degrees(+45)))
		}
	}
}

public extension StandardModel {
	init(scale value: Double) {
		range = 0 ... 300
		values = [value]
		self.ticks = [
			Tick(10.0 * (1.0 / 0.453592), ends: .both),
			Tick(20.0)
		]
	}
}

#Preview {
	Scale.ScaleView()
}
