//
//  Ticking.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import Foundation
import SwiftUI

public struct Tick {
	public typealias Value = Double

	public let increment: Value
	public let filter: (Int, Value) -> Bool

	public init(
		_ increment: Value = 1.0,
		filter: @escaping (Int, Value) -> Bool = { _, _ in true } ) {
			self.increment = increment
			self.filter = filter
	}
}

public enum TickEnds {
	case both
	case start
	case end
}

public protocol Ticking {
	typealias Value = Double
	typealias TickIdx = Int
	var ticks: [Tick] { get set }
	var tickEnds: TickEnds { get set }
}

public extension Ticking where Self: Values {
	func tickValues(_ tick: Tick) -> [(element: Double, offset: Int)] {
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
}

public extension Ticking where Self: Values & Radial {
	func tickAngles(_ tick: Tick) -> [(element: Double, offset: Int, angle: Angle)] {
		tickValues(tick).map { (value, offset) in
			(value, offset, angle(value: value))
		}
	}
}
