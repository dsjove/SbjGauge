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
	public let filter: (Value, Int) -> Bool

	public init(
		_ increment: Value = 1.0,
		ends: TickEnds = .start,
		filter: @escaping (Value, Int) -> Bool = { _, _ in true } ) {
			self.increment = increment
			self.ends = ends
			self.filter = filter
	}

	func values(_ range: ClosedRange<Value>) -> [(element: Value, offset: Int)] {
		var result: [(Value, Int)] = []
		result.reserveCapacity(Int((range.upperBound - range.lowerBound) / increment) + 1)
		var element = range.lowerBound
		var offset = 0
		while element <= range.upperBound {
			if offset != 0 || ends != .end {
				if filter(element, offset) {
					result.append((element, offset))
				}
			}
			element += increment
			offset += 1
		}
		if ends == .start {
			result.removeLast()
		}
		return result
	}
}

public protocol Ticking {
	typealias Value = Tick.Value
	typealias TickIdx = Int
	var ticks: [Tick] { get set }
}

public extension Ticking where Self: Values & Radial {
	func tickAngles(_ tick: Tick) -> [(element: Value, offset: Int, angle: Angle)] {
		tick.values(range).map { (value, offset) in
			(value, offset, angle(value: value))
		}
	}
}
