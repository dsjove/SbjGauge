//
//  RadialRotateModifier.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Standard {
	public struct RadialRotateModifier<Value>: ViewModifier {
		let needle: Needle<Value>
		let clockwise: Bool

		public init(needle: Needle<Value>, clockwise: Bool = true) {
			self.needle = needle
			self.clockwise = clockwise
		}

		public func body(content: Content) -> some View {
			content
		//TODO: Does the `+ .degrees(360.0)` always fix the 'rotate in correct direction'?
				.rotationEffect((needle.angle + .degrees(360.0)) * (clockwise ? 1 : -1))
		//TODO: fix warning
				.animation(.linear(duration: 0.1))
		}
	}
}

public extension View {
	func radialRotate<Value>(_ needle: Needle<Value>, clockwise: Bool = true) -> some View {
		return self.modifier(Standard.RadialRotateModifier(needle: needle, clockwise: clockwise))
	}
}

#Preview {
	Standard.GeometryView() { geom in
		Standard.NeedleView(geom: geom)
			.radialRotate(StandardModel(standard: 3.33).needle())
	}
}
