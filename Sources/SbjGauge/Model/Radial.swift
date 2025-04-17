//
//  Radial.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import SwiftUI

public protocol Radial {
	var angles: ClosedRange<Angle> { get set }
}

public extension Radial {
	func norm(angle: Angle) -> Double {
		angles.norm(angle)
	}

	func angle(norm: Double) -> Angle {
		angles.value(norm)
	}
}

public extension Radial where Self: Values {
	func angle(value: Value) -> Angle {
		angle(norm: norm(value: value))
	}

	func value(angle: Angle) -> Value {
		value(norm: norm(angle: angle))
	}
}
