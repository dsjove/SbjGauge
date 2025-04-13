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
		public init(value: Double, range: ClosedRange<Double> = 0 ... 10) {
			self.values = [value]
			self.range = range
		}

// Radial
		public var range: ClosedRange<Double>

		public func norm(value: Double) -> Double {
			(range.clamp(value) - range.lowerBound) / (range.upperBound - range.lowerBound)
		}

		public func value(norm: Double) -> Double {
			range.lowerBound + (norm * (range.upperBound - range.lowerBound))
		}

		public var angles: ClosedRange<Angle> = .degrees(0) ... .degrees(360)

		public func norm(angle: Angle) -> Double {
			(angle.degrees - angles.lowerBound.degrees) / (angles.upperBound.degrees - angles.lowerBound.degrees)
		}

		public func angle(norm: Double) -> Angle {
			.degrees(angles.lowerBound.degrees + (norm * (angles.upperBound.degrees - angles.lowerBound.degrees)))
		}

		public func angle(value: Double) -> Angle {
			angle(norm: norm(value: value))
		}

		public func value(angle: Angle) -> Double {
			value(norm: norm(angle: angle))
		}

// Needles
		public var values: [Double]

		subscript(index: Int) -> Double {
			get { values[index] }
			set { values[index] = range.clamp(newValue) }
		}

		subscript(norm index: Int) -> Double {
			get { norm(value: values[index]) }
			set { values[index] = value(norm: newValue) }
		}

// Ticks
		public var tickIncrements: [Double] = [1, 1]
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
		public var spans: [Span] = []

		func span(for value: Double) -> (Int, Span)? {
			for span in spans.enumerated().reversed() {
				if span.element.range.contains(value) {
					return (span.offset, span.element)
				}
			}
			return nil
		}
	}
}
