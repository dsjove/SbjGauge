//
//  Model.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

/**
 * Convenience method to clamp a value in a closed ranged
 * I think this is built in now.
 */
extension ClosedRange {
	func clamp(_ value : Bound) -> Bound {
		self.lowerBound > value ? self.lowerBound :
		self.upperBound < value ? self.upperBound :
		value
	}
}

extension ClosedRange where Bound == Double {
	func norm(_ value: Double) -> Double {
		(clamp(value) - lowerBound) / (upperBound - lowerBound)
	}

	func value(_ norm: Double) -> Double {
		lowerBound + (norm * (upperBound - lowerBound))
	}
}

extension ClosedRange where Bound == Angle {
	func norm(_ angle: Angle) -> Double {
		(angle.degrees - lowerBound.degrees) / (upperBound.degrees - lowerBound.degrees)
	}

	func value(_ norm: Double) -> Angle {
		.degrees(lowerBound.degrees + (norm * (upperBound.degrees - lowerBound.degrees)))
	}
}

//TODO: break up into readonly protocols with associated types
/**
 * Model has the non-geometric/layout values
 * Angle needs to be moved out
 * Color may likely move in
 */
public struct Model {
	public init(value: Double, range: ClosedRange<Double> = 0 ... 10) {
		self.values = [range.clamp(value)]
		self.range = range
	}

	public var range: ClosedRange<Double>

	public func norm(value: Double) -> Double {
		range.norm(value)
	}

	public func value(norm: Double) -> Double {
		range.value(norm)
	}

// Radial
	public var angles: ClosedRange<Angle> = .degrees(0) ... .degrees(360)

	public func norm(angle: Angle) -> Double {
		angles.norm(angle)
	}

	public func angle(norm: Double) -> Angle {
		angles.value(norm)
	}

	public func angle(value: Double) -> Angle {
		angle(norm: norm(value: value))
	}

	public func value(angle: Angle) -> Double {
		value(norm: norm(angle: angle))
	}

// Needles
	public typealias NeedleIdx = Int
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
	public typealias TickLabel = String
	public struct Tick {
		public let increment: Double
		public let filter: (Int, Double) -> Bool
		public let label: ((Int, Double) -> TickLabel)?

		public init(
			_ increment: Double = 1.0,
			filter: @escaping (Int, Double) -> Bool = { _, _ in true },
			label: ((Int, Double) -> TickLabel)? = {_, value in Int(value).description} ) {
				self.increment = increment
				self.filter = filter
				self.label = label
		}
	}
	public typealias TickIdx = Int
	public var ticks: [Tick] = [.init(), .init()]
	public enum TickEnds {
		case both
		case start
		case end
	}
	var tickEnds: TickEnds = .start

	public func tickValues(_ tick: Tick) -> [(element: Double, offset: Int)] {
		var result: [(Double, Int)] = []
		result.reserveCapacity(Int((range.upperBound - range.lowerBound) / tick.increment) + 1)
		var element = range.lowerBound
		var offset = 0
		while element <= range.upperBound {
			if offset != 0 || tickEnds != .end {
				if tick.filter(offset, element) {
					result.append((element, offset))
				}
			}
			element += tick.increment
			offset += 1
		}
		if tickEnds == .start {
			result.removeLast()
		}
		return result
	}

// Spans
	public typealias SpanLabel = String
	public struct Span {
		public let range: ClosedRange<Double>
		public let label: SpanLabel?

		init(_ range: ClosedRange<Double>, _ label: String? = nil) {
			self.range = range
			self.label = label
		}
	}
	public typealias SpanIdx = Int
	public var spans: [Span] = []

	func span(for value: Double) -> (SpanIdx, Span)? {
		for span in spans.enumerated().reversed() {
			if span.element.range.contains(value) {
				return (span.offset, span.element)
			}
		}
		return nil
	}
}
