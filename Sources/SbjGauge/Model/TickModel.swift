//
//  TickModel.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import Foundation
import SwiftUI

public struct Tick<Value: GaugeValue> {
	public let increment: Value.Stride
	public let ends: ClampStyle
	public let filter: (Value, Int) -> Bool

	public init(
		_ increment: Value.Stride,
		ends: ClampStyle = .cycleOpenUpper,
		filter: @escaping (Value, Int) -> Bool = { _, _ in true } ) {
			self.increment = increment
			self.ends = ends
			self.filter = filter
	}

	func stride(_ range: ClosedRange<Value>) -> [(element: Value, offset: Int)] {
		var result: [(Value, Int)] = []
		//result.reserveCapacity(Int((range.upperBound.toDouble - range.lowerBound.toDouble) / increment.toDouble) + 1)
		var element = range.lowerBound
		var offset = 0
		var appended = false
		while element <= range.upperBound {
			if offset != 0 || ends != .cycleOpenLower {
				if filter(element, offset) {
					result.append((element, offset))
					appended = true;
				}
			}
			element = element.advanced(by: increment)
			offset += 1
		}
		if ends == .cycleOpenUpper && appended && !result.isEmpty {
			result.removeLast()
		}
		return result
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

public extension RadialModel {
	func tickNotches(_ tick: Tick<Value>) -> [TickNotch<Value>] {
		let values = tick.stride(self.range)
		let count = values.count
		return values.map { (value, offset) in
			.init(offset, count, value, angle(value: value))
		}
	}
}
