//
//  Ticking.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import Foundation
import SwiftUI

public enum TickEnds {
	case both
	case start
	case end
}

public struct Tick {
	public typealias Value = Double

	public let increment: Value
	public let ends: TickEnds
	public let filter: (Int, Value) -> Bool

	public init(
		_ increment: Value = 1.0,
		ends: TickEnds = .start,
		filter: @escaping (Int, Value) -> Bool = { _, _ in true } ) {
			self.increment = increment
			self.ends = ends
			self.filter = filter
	}
}

public protocol Ticking {
	typealias Value = Tick.Value
	typealias TickIdx = Int
	var ticks: [Tick] { get set }
}

public extension Ticking where Self: Values {
	func tickValues(_ tick: Tick) -> [(element: Value, offset: Int)] {
		var result: [(Value, Int)] = []
		result.reserveCapacity(Int((range.upperBound - range.lowerBound) / tick.increment) + 1)
		var element = range.lowerBound
		var offset = 0
		while element <= range.upperBound {
			if offset != 0 || tick.ends != .end {
				if tick.filter(offset, element) {
					result.append((element, offset))
				}
			}
			element += tick.increment
			offset += 1
		}
		if tick.ends == .start {
			result.removeLast()
		}
		return result
	}
}

public extension Ticking where Self: Values & Radial {
	func tickAngles(_ tick: Tick) -> [(element: Value, offset: Int, angle: Angle)] {
		tickValues(tick).map { (value, offset) in
			(value, offset, angle(value: value))
		}
	}
}
