//
//  TickModel.swift
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

public struct Tick<Value: GaugeValue> {
	public let increment: Value
	public let ends: TickEnds
	public let filter: (Value, Int) -> Bool

	public init(
		_ increment: Value,
		ends: TickEnds = .start,
		filter: @escaping (Value, Int) -> Bool = { _, _ in true } ) {
			self.increment = increment
			self.ends = ends
			self.filter = filter
	}

	func values(_ range: ClosedRange<Value>) -> [(element: Value, offset: Int)] {
		var result: [(Value, Int)] = []
		//result.reserveCapacity(Int((range.upperBound - range.lowerBound) / increment) + 1)
		var element = range.lowerBound
		var offset = 0
		var appended = false
		while element <= range.upperBound {
			if offset != 0 || ends != .end {
				if filter(element, offset) {
					result.append((element, offset))
					appended = true;
				}
			}
			element += increment
			offset += 1
		}
		if ends == .start && appended && !result.isEmpty {
			result.removeLast()
		}
		return result
	}
}

public protocol TickModel: GaugeModel {
	var ticks: [Tick<Value>] { get }
}

public extension TickModel {
	func values(_ tick: Tick<Value>) -> [(element: Value, offset: Int)] {
		tick.values(range)
	}
}

public struct TickNotch<Value> {
	public let idx: Int
	public let count: Int
	public let value: Value
	public let angle: Angle

	public init(_ idx: Int, _ count: Int, _ value: Value, _ angle: Angle) {
		self.idx = idx
		self.count = count
		self.value = value
		self.angle = angle
	}
}

public extension TickModel where Self: RadialModel {
	func tickNotches(_ tick: Tick<Value>) -> [TickNotch<Value>] {
		let values = values(tick)
		let count = values.count
		return values.map { (value, offset) in
			.init(offset, count, value, angle(value: value))
		}
	}
}
