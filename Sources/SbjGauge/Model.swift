//
//  Model.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

extension Gauge {

	/**
	 * Model has the non-rendering multivalues of the gauge.
	 * 'angles' will likely move out into another object.
	 * This struct will be broken up for each gauge component.
	 */
	public struct Model {
	
		public init(value: Double = 0, range: ClosedRange<Double> = 0 ... 10) {
			self.values = [value]
			self.range = range
		}

// Radial
		public var range: ClosedRange<Double>

		public var angles: ClosedRange<Angle> = .degrees(0) ... .degrees(360)

		public func angle(_ value: Double) -> Angle {
			let scale = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
			let angle = angles.lowerBound.degrees + (scale * (angles.upperBound.degrees - angles.lowerBound.degrees))
			return .degrees(angle)
		}

		public func value(angle: Angle) -> Double {
			let scale = (angle.degrees - angles.lowerBound.degrees) / (angles.upperBound.degrees - angles.lowerBound.degrees)
			return range.lowerBound + (scale * (range.upperBound - range.lowerBound))
		}

// Needles
		public var values: [Double?]

// Ticks
		public var tickIncrements: [Double?] = [1, 1]
		public enum TickEnds {
			case both
			case start
			case end
		}
		var tickEnds: TickEnds = .start

		public func tickValues(inc: Double) -> [(element: Double, offset: Int)] {
			var result: [(Double, Int)] = []
			result.reserveCapacity(Int((range.upperBound - range.lowerBound) / inc) + 1)
			var element = range.lowerBound
			var offset = 0
			while element <= range.upperBound {
				if offset != 0 || tickEnds != .end {
					result.append((element, offset))
				}
				element += inc
				offset += 1
			}
			if tickEnds == .start {
				result.removeLast()
			}
			return result
		}

// Spans
		public struct Span {
			public let range: ClosedRange<Double>
			public let label: String?

			init(_ range: ClosedRange<Double>, _ label: String? = nil) {
				self.range = range
				self.label = label
			}
		}
		public var spans: [Span?] = []

		func span(for value: Double) -> (Int, Span)? {
			for span in spans.enumerated().reversed() {
				if let test = span.element, test.range.contains(value) {
					return (span.offset, test)
				}
			}
			return nil
		}
	}
}
