//
//  Radial.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import SwiftUI

public struct Needle {
	public let idx: Int
	public let count: Int
	public let value: Double
	public let angle: Angle

	public init(_ idx: Int, _ count: Int, _ value: Double, _ angle: Angle) {
		self.idx = idx
		self.count = count
		self.value = value
		self.angle = angle
	}
}

public protocol Radial: Values {
	var angles: ClosedRange<Angle> { get set }
}

public extension Radial {
	func angle(value: Value) -> Angle {
		angles.value(range.norm(value))
	}

	func value(angle: Angle) -> Value {
		range.value(angles.norm(angle))
	}

	func needles() -> [Needle] {
		values.enumerated().map { Needle($0.offset, values.count, $0.element, angle(value: $0.element)) }
	}
}
