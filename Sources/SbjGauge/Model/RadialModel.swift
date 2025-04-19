//
//  RadialModel.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import SwiftUI

public protocol RadialModel: GaugeModel {
	var angles: ClosedRange<Angle> { get set }
}

extension Angle : GaugeValue {
	public init(double: Double) { self = .degrees(double) }
	public var toDouble: Double { self.degrees }
}

public extension RadialModel {
	func angle(value: Value) -> Angle {
		angles.value(range.norm(value))
	}

	func value(angle: Angle) -> Value {
		range.value(angles.norm(angle))
	}
}

public struct Needle<Value> {
	public typealias ValueIdx = Int
	public let idx: ValueIdx
	public let count: Int
	public let value: Value
	public let angle: Angle

	public init(_ idx: ValueIdx, _ count: Int, _ value: Value, _ angle: Angle) {
		self.idx = idx
		self.count = count
		self.value = value
		self.angle = angle
	}
}

public extension RadialModel where Self: ValuesModel {
	func needles() -> [Needle<Value>] {
		values.enumerated().map { Needle($0.offset, values.count, $0.element, angle(value: $0.element)) }
	}
}
