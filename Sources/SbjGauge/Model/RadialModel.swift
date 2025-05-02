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

extension Angle: GaugeValue, @retroactive Strideable {
	public init(double: Double) { self = .degrees(double) }
	public var toDouble: Double { self.degrees }

	public func distance(to other: Angle) -> Double {
		self.toDouble.distance(to: other.toDouble)
	}
	
	public func advanced(by n: Double) -> Angle {
		.init(double: self.toDouble.advanced(by: n))
	}
}

public struct Needle<Value> {
	public let value: Value
	public let angle: Angle

	public init(_ value: Value, _ angle: Angle) {
		self.value = value
		self.angle = angle
	}
}

public extension RadialModel {
	var angles: ClosedRange<Angle> { .degrees(0) ... .degrees(360) }

	func angle(value: Value) -> Angle {
		angles.value(range.norm(value))
	}

	func value(angle: Angle) -> Value {
		range.value(angles.norm(angle))
	}

	func needle(_ idx: Int = 0) -> Needle<Value> {
		let value = self[idx]
		return Needle(value, angle(value: value))
	}

	func needle<Name: RawRepresentable>(_ idx: Name) -> Needle<Value> where Name.RawValue == Int {
		return needle(idx.rawValue)
	}
}
