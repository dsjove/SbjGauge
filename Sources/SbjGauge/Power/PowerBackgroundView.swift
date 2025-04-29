//
//  PowerBackgroundView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Power {
	public struct BackgroundView: View {
		let geom: GeometryProxy
		let color: Color

		public init(
			geom: GeometryProxy,
			color: Color = .sbjGauge("Power/Background")) {
			self.geom = geom
			self.color = color
		}

		public var body: some View {
			Circle()
				.fill(.radialGradient(
					stops: [
						Gradient.Stop(
							color: Color(0.375, 0.375, 0.375), location: 0.35),
						Gradient.Stop(
							color: Color(0.265, 0.265, 0.265), location: 0.96),
						Gradient.Stop(
							color: Color(0.125, 0.125, 0.125), location: 1.0),
					], center: UnitPoint(x: 0.5, y: 0.5), startRadius: 0, endRadius: geom.radius))
					.colorMultiply(color)
			Circle()
				.fill(.radialGradient(
					stops: [
						Gradient.Stop(
							color: Color(0.156, 0.375, 0.664, 0.234), location: 0.60),
						Gradient.Stop(
							color: Color(0.059, 0.132, 0.382, 0.312), location: 0.85),
						Gradient.Stop(
							color: Color(0.0, 0.0, 0.0, 0.468), location: 0.96),
						Gradient.Stop(
							color: Color(0.0, 0.0, 0.0, 0.546), location: 1.0),
					], center: UnitPoint(x: 0.5, y: 0.5), startRadius: 0, endRadius: geom.radius))
					.colorMultiply(color)
		}
	}
}

#Preview {
	Standard.GeometryView() {
		Power.BackgroundView(geom: $0)
	}
}
