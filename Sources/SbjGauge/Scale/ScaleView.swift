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
			Standard.GeometryView() { geom in
				Standard.BackgroundView(geom: geom)
				
				Circle()
					.stroke(Color.black, lineWidth: geom.width(0.003))
					.frame(width: geom.width(0.80))

				Standard.RadialTickView(geom, model, model.ticks[0],
						radius: 0.8) { notch in
					let v = "\(Int(notch.value).description)\(notch.idx == 0 ? "lb" : "")"
					Standard.TickTextView(geom: geom,
						text: v,
						offset: -0.15)
					Standard.TickLineView(geom: geom,
						length: 0.05,
						offset: -0.05)
				}
				.radialRotate(model.needle(), clockwise: false)
				Standard.RadialTickView(geom, model, model.ticks[1],
						radius: 0.8) { notch in
					Standard.TickLineView(geom: geom,
						length: 0.03,
						offset: -0.03)
				}
				.radialRotate(model.needle(), clockwise: false)
				Standard.RadialTickView(geom, model, model.ticks[2],
						radius: 0.8) { notch in
					let v = "\(Int((notch.value * 0.453592).rounded(.up)).description)\(notch.idx == 0 ? "kg" : "")"
					Standard.TickTextView(geom: geom,
						text: v,
						length: notch.idx == notch.count-1 ? 0.075 : 0.1,
						offset: 0.05)
					Standard.TickLineView(geom: geom,
						length: 0.05,
						offset: 0.0)
				}
				.radialRotate(model.needle(), clockwise: false)
				Standard.RadialTickView(geom, model, model.ticks[3],
						radius: 0.8) { notch in
					Standard.TickLineView(geom: geom,
						length: 0.03,
						offset: 0.0)
				}
				.radialRotate(model.needle(), clockwise: false)

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
		self.init(value: value, range: 0 ... 300)

		self.ticks = [
			.init(20.0),
			.init(5.0),
			.init(10.0 * (1.0 / 0.453592), ends: .closed),
			.init(5.0 * (1.0 / 0.453592))
		]
	}
}

#Preview {
	Scale.ScaleView()
}
