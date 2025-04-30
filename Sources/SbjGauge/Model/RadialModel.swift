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
}
