//
//  IndicatorLayout.swift
//  SbjGauge
//
//  Created by David Giovannini on 12/12/22.
//  Based on: Apple's sample code

import SwiftUI

public extension Standard {
	/**
	 * This layout is specialized to work with the layout of the radial gauge.
	 */
	struct IndicatorLayout: Layout {
		public let radius: Double

		public func sizeThatFits(
			proposal: ProposedViewSize,
			subviews: Subviews,
			cache: inout Void) -> CGSize {
			proposal.replacingUnspecifiedDimensions()
		}

		public func placeSubviews(
			in bounds: CGRect,
			proposal: ProposedViewSize,
			subviews: Subviews,
			cache: inout Void) {

			let radius = min(bounds.size.width, bounds.size.height) * radius
			var angle = Angle.degrees(360.0 / Double(subviews.count)).radians

			let start: Double
			if (subviews.count == 1) {
				start = Angle.degrees(180.0).radians
			}
			else if (subviews.count == 2) {
				start = Angle.degrees(120.0).radians
				angle = Angle.degrees(360.0 / 3.0).radians
			}
			else {
				start = 0.0
			}

			let ranks = subviews.map { $0[Rank.self] }
			let offset = getOffset(ranks)

			for (index, subview) in subviews.enumerated() {
				var point = CGPoint(x: 0, y: -radius)
					.applying(CGAffineTransform(
						rotationAngle: start + angle * Double(index) + offset))

				point.x += bounds.midX
				point.y += bounds.midY

				subview.place(at: point, anchor: .center, proposal: .unspecified)
			}
		}

		private func getOffset(_ ranks: [Int]) -> Double {
			guard ranks.count == 3,
				  !ranks.allSatisfy({ $0 == ranks.first }) else { return 0.0 }

			var fraction: Double
			if ranks[0] == 1 {
				fraction = residual(rank1: ranks[1], rank2: ranks[2])
			}
			else if ranks[1] == 1 {
				fraction = -1 + residual(rank1: ranks[2], rank2: ranks[0])
			}
			else {
				fraction = 1 + residual(rank1: ranks[0], rank2: ranks[1])
			}

			return fraction * 2.0 * Double.pi / 3.0
		}

		private func residual(rank1: Int, rank2: Int) -> Double {
			if rank1 == 1 {
				return -0.5
			}
			else if rank2 == 1 {
				return 0.5
			}
			else if rank1 < rank2 {
				return -0.25
			}
			else if rank1 > rank2 {
				return 0.25
			}
			else {
				return 0
			}
		}
	}

	struct Rank: LayoutValueKey {
		public static let defaultValue: Int = 1
	}
}

public extension View {
	func indicatorRank(_ value: Int) -> some View {
		layoutValue(key: Standard.Rank.self, value: value)
	}
}
